import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String statusMsg = '';
  bool isSuccess = false;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController subjectCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      loading = true;
      statusMsg = '';
    });

    // Giả lập gửi API, bạn thay bằng API thật nếu muốn
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
      statusMsg = "Thank you for contacting us! We'll get back to you within 24 hours.";
      isSuccess = true;
      nameCtrl.clear();
      emailCtrl.clear();
      phoneCtrl.clear();
      subjectCtrl.clear();
      messageCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        Container(
          height: 220,
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
                children: const [
                  Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We're here to help you on your wellness journey. Reach out to us anytime.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Contact Info Cards
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _infoCard(Icons.phone, 'Call Us', '+1 (555) 123-4567', '24/7 Emergency'),
                _infoCard(Icons.email, 'Email Us', 'info@medicalcenter.com', 'Quick Response'),
                _infoCard(Icons.location_on, 'Visit Us', '123 Medical Center', 'Health City'),
                _infoCard(Icons.access_time, 'Hours', 'Mon - Fri: 7:00 - 17:00', 'Sat: 7:00 - 16:00'),
              ],
            ),
          ),
          // Contact Form
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Get in Touch',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF223a66)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Ready to start your wellness journey? Send us a message and we'll respond within 24 hours.",
                        style: TextStyle(color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (statusMsg.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSuccess ? Colors.green[50] : Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSuccess ? Icons.check_circle : Icons.error,
                                color: isSuccess ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  statusMsg,
                                  style: TextStyle(
                                    color: isSuccess ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Full Name *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: emailCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Email Address *',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: phoneCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: subjectCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Subject',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: messageCtrl,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Message *',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: loading ? null : handleSubmit,
                          icon: loading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.send),
                          label: Text(loading ? 'Sending...' : 'Send Message'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF23cf7c),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Map Section (dùng Google Maps Flutter nếu muốn, ở đây chỉ là placeholder)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
                      ),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: const Center(
                      child: Text(
                        'Our Location',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text('Google Map Placeholder'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on, color: Color(0xFF23cf7c)),
                        SizedBox(width: 8),
                        Text(
                          'Medical Center',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223a66)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '123 Health Street, Medical District, Health City, HC 12345',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

  Widget _infoCard(IconData icon, String title, String value, String desc) {
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
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFF23cf7c),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223a66))),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.black87), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}