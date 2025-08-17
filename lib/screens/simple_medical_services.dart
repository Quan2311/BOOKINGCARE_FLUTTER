import 'package:flutter/material.dart';
import '../models/specialty.dart';
import '../services/medical_service.dart';

class SimpleMedicalServices extends StatefulWidget {
  const SimpleMedicalServices({Key? key}) : super(key: key);

  @override
  State<SimpleMedicalServices> createState() => _SimpleMedicalServicesState();
}

class _SimpleMedicalServicesState extends State<SimpleMedicalServices> {
  List<Specialty> specialties = [];
  bool loading = true;
  String errorMsg = '';
  Specialty? selectedSpecialty;
  // Specialty? selectedSpecialty;

  @override
  void initState() {
    super.initState();
    fetchSpecialties();
  }

  Future<void> fetchSpecialties() async {
    try {
      setState(() {
        loading = true;
        errorMsg = '';
      });

      final result = await MedicalService.getSpecialties();
      print('API Result: ${result['success']}');

      if (result['success'] && result['data'] != null) {
        List<dynamic> specialtyList = List.from(result['data']);
        
        if (specialtyList.isNotEmpty) {
          setState(() {
            specialties = specialtyList.map((json) => Specialty.fromJson(json)).toList();
            selectedSpecialty = specialties.first;
            loading = false;
            errorMsg = 'Loaded ${specialties.length} specialties from API';
          });
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
        errorMsg = 'Error: $e';
      });
    }
  }

  void _selectSpecialty(Specialty specialty) {
    setState(() {
      selectedSpecialty = specialty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF223a66), Color(0xFF4a6fa5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Award Winning Patient Care',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Let us better understand the need for pain so that we can become more resilient.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              if (errorMsg.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMsg,
                    style: TextStyle(color: Colors.pink.shade700),
                  ),
                ),
            ],
          ),
        ),
        
        // Content
        Container(
          padding: const EdgeInsets.all(50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left sidebar - Medical Departments
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Medical Departments',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF223a66),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (loading)
                      const Center(child: CircularProgressIndicator())
                    else if (specialties.isEmpty)
                      const Text('No specialties available')
                    else
                      ...specialties.map((specialty) => InkWell(
                        onTap: () => _selectSpecialty(specialty),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: selectedSpecialty?.id == specialty.id 
                                ? Colors.blue.shade50 
                                : Colors.white,
                            border: Border.all(
                              color: selectedSpecialty?.id == specialty.id 
                                  ? Colors.blue.shade300 
                                  : Colors.grey.shade300,
                              width: selectedSpecialty?.id == specialty.id ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  specialty.specialtyName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedSpecialty?.id == specialty.id 
                                        ? Colors.blue.shade700 
                                        : const Color(0xFF223a66),
                                    fontWeight: selectedSpecialty?.id == specialty.id 
                                        ? FontWeight.bold 
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: selectedSpecialty?.id == specialty.id 
                                    ? Colors.blue.shade700 
                                    : const Color(0xFF223a66),
                              ),
                            ],
                          ),
                        ),
                      )),
                  ],
                ),
              ),
              
              const SizedBox(width: 50),
              
              // Right content
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Medical icon
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade200, Colors.blue.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.medical_services,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Service details
                    if (selectedSpecialty != null)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigate to medical service detail page using route
                                print('Navigating to: /medical-services/${selectedSpecialty!.id}');
                                Navigator.pushNamed(
                                  context,
                                  '/medical-services/${selectedSpecialty!.id}',
                                );
                              },
                              child: Text(
                                selectedSpecialty!.specialtyName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF223a66),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.attach_money, 
                                           color: Colors.green.shade700, size: 16),
                                      Text(
                                        'Service Price',
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.schedule, 
                                           color: Colors.blue.shade700, size: 16),
                                      Text(
                                        'Available',
                                        style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  '${selectedSpecialty!.price.toStringAsFixed(0)} VND',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Text(
                                  'Mon - Fri, 9AM - 8PM',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
