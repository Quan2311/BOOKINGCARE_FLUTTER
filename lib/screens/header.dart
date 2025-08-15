import 'package:flutter/material.dart';
import '../services/api_service.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderState extends State<Header> {
  Map<String, dynamic>? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    setState(() => isLoading = true);
    
    try {
      final isLoggedIn = await ApiService.isLoggedIn();
      if (isLoggedIn) {
        final currentUser = await ApiService.getCurrentUser();
        setState(() {
          user = currentUser;
          isLoading = false;
        });
      } else {
        setState(() {
          user = null;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        user = null;
        isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await ApiService.logout();
    setState(() => user = null);
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF223a66),
      title: Row(
        children: [
          Image.asset(
            'assets/images/LOGO SPA-01.png',
            height: 40,
          ),
          const SizedBox(width: 16),
          const Text(
            'Health Clinic',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          child: const Text('Home', style: TextStyle(color: Color(0xFF4ade80))),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/about'),
          child: const Text('About', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          child: const Text('Contact', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 20),
        
        // User Menu
        if (isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
          )
        else if (user != null)
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'profile':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('My Profile - Coming soon!')),
                  );
                  break;
                case 'bookings':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('My Bookings - Coming soon!')),
                  );
                  break;
                case 'logout':
                  _handleLogout();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?['fullname'] ?? user?['full_name'] ?? 'User',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223a66)),
                    ),
                    Text(
                      user?['email'] ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Color(0xFF4ade80)),
                    SizedBox(width: 8),
                    Text('My Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'bookings',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Color(0xFF4ade80)),
                    SizedBox(width: 8),
                    Text('My Bookings'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF4ade80),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: Text(
                      (user?['fullname'] ?? user?['full_name'] ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF4ade80),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user?['fullname'] ?? user?['full_name'] ?? 'User',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                ],
              ),
            ),
          )
        else
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            icon: const Icon(Icons.person, color: Colors.white),
            label: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        const SizedBox(width: 16),
      ],
    );
  }
}