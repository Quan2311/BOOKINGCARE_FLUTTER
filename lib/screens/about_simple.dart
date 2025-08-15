import 'package:flutter/material.dart';

class AboutSimple extends StatelessWidget {
  const AboutSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'About Health Clinic',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF223a66),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Health Clinic - Your trusted healthcare partner.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 30),
          
          // Hero Section
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Quality Healthcare for Everyone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Stats Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('25+', 'Years Experience'),
              _buildStatItem('10,000+', 'Patients'),
              _buildStatItem('50+', 'Doctors'),
              _buildStatItem('30+', 'Awards'),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Features
          const Text(
            'Our Services',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF223a66),
            ),
          ),
          const SizedBox(height: 20),
          
          _buildFeatureItem('24/7 Emergency Care'),
          _buildFeatureItem('Expert Medical Staff'),
          _buildFeatureItem('Modern Equipment'),
          _buildFeatureItem('Comprehensive Health Checkups'),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF223a66),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF223a66),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            feature,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
