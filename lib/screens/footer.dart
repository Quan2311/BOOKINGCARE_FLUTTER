import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final VoidCallback? onScrollToTop;
  const Footer({Key? key, this.onScrollToTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2d3748),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          // Top section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo & About
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/LOGO SPA-01.png', width: 120),
                    const SizedBox(height: 8),
                    const Text(
                      'Tempora dolorem voluptatum nam vero assumenda voluptate, facilis ad eos obcaecati tenetur veritatis eveniet distinctio possimus.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _iconButton(Icons.facebook, 'https://www.facebook.com/themefisher'),
                        // _iconButton(Icons.twitter, 'https://twitter.com/themefisher'),
                        // _iconButton(Icons.linkedin, 'https://www.pinterest.com/themefisher/'),
                      ],
                    ),
                  ],
                ),
              ),
              // Department
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Department', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    _footerLink('Surgery'),
                    _footerLink("Women's Health"),
                    _footerLink('Radiology'),
                    _footerLink('Cardioc'),
                    _footerLink('Medicine'),
                  ],
                ),
              ),
              // Support
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    _footerLink('Terms & Conditions'),
                    _footerLink('Privacy Policy'),
                    _footerLink('Company Support'),
                    _footerLink('FAQ'),
                    _footerLink('Company Licence'),
                  ],
                ),
              ),
              // Contact
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Get in Touch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.white70, size: 18),
                        SizedBox(width: 8),
                        Text('Support Available 24/7', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('support@email.com', style: TextStyle(color: Colors.white54)),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.white70, size: 18),
                        SizedBox(width: 8),
                        Text('Mon to Fri : 08:30 - 18:00', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('+1234567890', style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Bottom section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2021, Designed & Developed by FptAptech',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Your Email address',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF252525),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
                      ),
                    ),
                    child: const Text('Subscribe'),
                  ),
                ],
              ),
             IconButton(
  onPressed: onScrollToTop,
  icon: const Icon(Icons.arrow_upward, color: Colors.white),
),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _iconButton(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: Colors.white70),
      onPressed: () {},
    );
  }
}

class _footerLink extends StatelessWidget {
  final String text;
  const _footerLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text, style: const TextStyle(color: Colors.white54)),
    );
  }
}
