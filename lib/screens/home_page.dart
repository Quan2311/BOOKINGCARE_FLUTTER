import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        Container(
          height: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  const Text(
                    'Your Health,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Text(
                    'Our Priority',
                    style: TextStyle(
                      color: Color(0xFF23cf7c),
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Experience world-class medical care with cutting-edge technology',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF23cf7c),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {},
                        child: const Text('Book Appointment'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {},
                        child: const Text('Learn More'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Services Section
          Container(
            color: const Color(0xFFF7FAFC),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Column(
              children: [
                const Text(
                  'We offer Services',
                  style: TextStyle(
                    color: Color(0xFF223a66),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Our Specialties',
                  style: TextStyle(
                    color: Color(0xFF223a66),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Comprehensive healthcare solutions tailored to your needs',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _serviceCard(Icons.medical_services, 'General Medicine', 'Complete health checkups and preventive care with experienced physicians'),
                    _serviceCard(Icons.favorite, 'Cardiology', 'Advanced heart care and cardiovascular treatments by specialists'),
                    _serviceCard(Icons.remove_red_eye, 'Ophthalmology', 'Comprehensive eye care and vision treatments with latest technology'),
                    _serviceCard(Icons.accessibility, 'Orthopedics', 'Bone, joint, and muscle care solutions for all ages'),
                    _serviceCard(Icons.child_care, 'Pediatrics', 'Specialized care for children and infants with gentle approach'),
                    _serviceCard(Icons.access_time, 'Emergency Care', '24/7 emergency medical services for urgent healthcare needs'),
                  ],
                ),
              ],
            ),
          ),
          // About Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Our Clinic',
                  style: TextStyle(
                    color: Color(0xFF223a66),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Why Choose Our Care',
                  style: TextStyle(
                    color: Color(0xFF223a66),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'With over 20 years of excellence in healthcare, we combine advanced medical technology with compassionate care to deliver the best outcomes for our patients and their families.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _statCard('25+', 'Years of Experience'),
                    _statCard('10,000+', 'Happy Patients'),
                    _statCard('50+', 'Expert Doctors'),
                    _statCard('24/7', 'Emergency Care'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/home3.jpg',
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF223a66),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Award Winning',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Healthcare Provider',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

  static Widget _serviceCard(IconData icon, String title, String desc) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF23cf7c), size: 40),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223a66))),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: Colors.black54), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  static Widget _statCard(String number, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF23cf7c),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF223a66), fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}