import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(),
          
          // Main About Section
          _buildMainAboutSection(),
          
          // Stats Section
          _buildStatsSection(),
          
          // History Section
          _buildHistorySection(),
          
          // Testimonials Section
          _buildTestimonialsSection(),
          
          // Values Section
          _buildValuesSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          // Background image overlay
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LEARN ABOUT US',
                    style: TextStyle(
                      color: Color(0xFF93C5FD),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(text: 'About Our '),
                        TextSpan(
                          text: 'Clinic',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF23cf7c),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Dedicated to providing exceptional healthcare with compassion and excellence',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WELCOME TO OUR MEDICAL CENTER',
                      style: TextStyle(
                        color: Color(0xFF223a66),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF223a66),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: 'Your Health, '),
                          TextSpan(
                            text: 'Our Mission',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'With over 25 years of excellence in healthcare, we combine advanced medical technology with compassionate care to deliver the best outcomes for our patients and their families.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Our state-of-the-art facility houses the latest medical equipment and technologies, while our team of expert physicians and healthcare professionals work tirelessly to provide personalized treatment plans for every patient.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Feature List
                    Column(
                      children: [
                        '24/7 Emergency Medical Services',
                        'State-of-the-art Medical Equipment',
                        'Experienced Medical Professionals',
                        'Comprehensive Health Checkups',
                      ].map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Color(0xFF23cf7c),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              feature,
                              style: const TextStyle(
                                color: Color(0xFF374151),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 64),
              
              // Image Column
              Expanded(
                child: Stack(
                  children: [
                    // Main Image
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/home3.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    
                    // Floating Card
                    Positioned(
                      bottom: -20,
                      right: -20,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFF23cf7c),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified_user,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Certified',
                                  style: TextStyle(
                                    color: Color(0xFF223a66),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Healthcare Provider',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {'number': 25, 'label': 'Years of Experience', 'icon': Icons.calendar_today},
      {'number': 10000, 'label': 'Happy Patients', 'icon': Icons.people},
      {'number': 50, 'label': 'Expert Doctors', 'icon': Icons.favorite},
      {'number': 30, 'label': 'Awards Won', 'icon': Icons.emoji_events},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      color: const Color(0xFFF9FAFB),
      child: Column(
        children: [
          const Text(
            'OUR ACHIEVEMENTS',
            style: TextStyle(
              color: Color(0xFF223a66),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Color(0xFF223a66),
                height: 1.2,
              ),
              children: [
                TextSpan(text: 'Trusted by '),
                TextSpan(
                  text: 'Thousands',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Numbers that speak for our commitment to excellence in healthcare',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 64),
          
          // Stats Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final stat = stats[index];
              return StatCard(
                number: stat['number'] as int,
                label: stat['label'] as String,
                icon: stat['icon'] as IconData,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
          const Text(
            'OUR JOURNEY',
            style: TextStyle(
              color: Color(0xFF223a66),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Color(0xFF223a66),
                height: 1.2,
              ),
              children: [
                TextSpan(text: 'Healthcare '),
                TextSpan(
                  text: 'History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Text(
                  'Founded in 1998, our medical center has been at the forefront of healthcare innovation for over two decades. What started as a small clinic has grown into a comprehensive healthcare facility serving thousands of patients annually.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Our commitment to excellence has earned us numerous accolades and the trust of our community. We continue to invest in the latest medical technologies and attract the finest healthcare professionals to ensure our patients receive world-class care.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Today, we stand as a beacon of hope and healing, dedicated to improving the health and well-being of every individual who walks through our doors.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      color: const Color(0xFF223a66),
      child: Column(
        children: [
          const Text(
            'PATIENT STORIES',
            style: TextStyle(
              color: Color(0xFF93C5FD),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1.2,
              ),
              children: [
                TextSpan(text: 'Happy Clients & '),
                TextSpan(
                  text: 'Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Real experiences from real patients who trust us with their health',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF93C5FD),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 64),
          
          // Testimonials Grid
          Row(
            children: [
              Expanded(
                child: _buildTestimonialCard(
                  quote: "The care I received here was exceptional. The doctors were thorough, compassionate, and made me feel comfortable throughout my treatment. I couldn't have asked for better healthcare.",
                  name: "Sarah Johnson",
                  role: "Marketing Manager",
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildTestimonialCard(
                  quote: "Outstanding medical facility with state-of-the-art equipment. The staff is incredibly professional and the doctors are among the best I've ever encountered. Highly recommend!",
                  name: "Michael Chen",
                  role: "Business Owner",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String quote,
    required String name,
    required String role,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_quote,
                color: Color(0xFF23cf7c),
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  quote,
                  style: const TextStyle(
                    color: Color(0xFFE0E7FF),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF23cf7c),
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      color: Color(0xFF93C5FD),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    final values = [
      {
        'icon': Icons.favorite,
        'title': 'Compassionate Care',
        'description': 'We treat every patient with empathy, respect, and genuine concern for their wellbeing.',
      },
      {
        'icon': Icons.security,
        'title': 'Safety First',
        'description': 'Patient safety is our top priority in every procedure and treatment we provide.',
      },
      {
        'icon': Icons.star,
        'title': 'Excellence',
        'description': 'We strive for the highest standards in medical care and patient satisfaction.',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      color: const Color(0xFFF9FAFB),
      child: Column(
        children: [
          const Text(
            'OUR CORE VALUES',
            style: TextStyle(
              color: Color(0xFF223a66),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Color(0xFF223a66),
                height: 1.2,
              ),
              children: [
                TextSpan(text: 'What We '),
                TextSpan(
                  text: 'Stand For',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          
          Row(
            children: values.map((value) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      value['icon'] as IconData,
                      color: const Color(0xFF23cf7c),
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      value['title'] as String,
                      style: const TextStyle(
                        color: Color(0xFF223a66),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      value['description'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final int number;
  final String label;
  final IconData icon;

  const StatCard({
    super.key,
    required this.number,
    required this.label,
    required this.icon,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _animation = IntTween(
      begin: 0,
      end: widget.number,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: const Color(0xFF23cf7c),
            size: 48,
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Text(
                '${_animation.value}${widget.number >= 1000 ? '+' : ''}',
                style: const TextStyle(
                  color: Color(0xFF223a66),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
