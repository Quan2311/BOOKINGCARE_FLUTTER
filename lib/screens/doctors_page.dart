import 'package:flutter/material.dart';
import '../models/specialty.dart';
import '../models/doctor.dart';
import '../services/medical_service.dart';
import '../services/doctor_service.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<Specialty> specialties = [];
  int? activeSpecialtyId;
  List<Doctor> doctors = [];
  String errorMsg = '';
  bool loadingSpecialties = true;
  bool loadingDoctors = false;

  @override
  void initState() {
    super.initState();
    fetchSpecialties();
  }

  // Fetch Specialties API using service
  Future<void> fetchSpecialties() async {
    try {
      setState(() {
        loadingSpecialties = true;
        errorMsg = '';
      });

      final response = await MedicalService.getSpecialties();
      if (response['success'] && response['data'] != null) {
        final List<dynamic> specialtyList = response['data'];
        setState(() {
          specialties = specialtyList.map((json) => Specialty.fromJson(json)).toList();
          if (specialties.isNotEmpty) {
            activeSpecialtyId = specialties[0].id;
          }
          loadingSpecialties = false;
        });

        // Fetch doctors for first specialty
        if (activeSpecialtyId != null) {
          fetchDoctors(activeSpecialtyId!);
        }
      } else {
        throw Exception('Không thể load chuyên khoa');
      }
    } catch (err) {
      setState(() {
        errorMsg = 'Lỗi load chuyên khoa: $err';
        loadingSpecialties = false;
      });
    }
  }

  // Fetch Doctors by specialty API using service
  Future<void> fetchDoctors(int specialtyId) async {
    try {
      setState(() {
        loadingDoctors = true;
      });

      final doctorList = await DoctorService.getDoctorsBySpecialty(specialtyId);
      setState(() {
        doctors = doctorList;
        loadingDoctors = false;
      });
    } catch (err) {
      setState(() {
        errorMsg = 'Lỗi load bác sĩ: $err';
        loadingDoctors = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            height: 350,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                // Background image overlay
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/about-banner.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
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
                          'MEDICAL PROFESSIONALS',
                          style: TextStyle(
                            color: Color(0xFF87CEEB),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Our ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: 'Specialists',
                                style: TextStyle(
                                  color: Color(0xFF23cf7c),
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Meet our team of experienced and dedicated healthcare professionals',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            child: Column(
              children: [
                // Section Header
                Column(
                  children: [
                    const Text(
                      'EXPERT MEDICAL TEAM',
                      style: TextStyle(
                        color: Color(0xFF223a66),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Specialized ',
                            style: TextStyle(
                              color: Color(0xFF223a66),
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'Doctors',
                            style: TextStyle(
                              color: Color(0xFF223a66),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'We provide a wide range of creative services with our experienced medical professionals.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Error Message
                if (errorMsg.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      border: Border.all(color: Colors.red[200]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      errorMsg,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Specialty Tabs
                if (loadingSpecialties)
                  const CircularProgressIndicator(color: Color(0xFF23cf7c))
                else
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: specialties.map((specialty) {
                      bool isActive = activeSpecialtyId == specialty.id;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: isActive 
                            ? (Matrix4.identity()..scale(1.05))
                            : Matrix4.identity(),
                        child: Material(
                          elevation: isActive ? 8 : 2,
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                activeSpecialtyId = specialty.id;
                              });
                              fetchDoctors(specialty.id);
                            },
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isActive 
                                    ? const Color(0xFF23cf7c)
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                specialty.specialtyName,
                                style: TextStyle(
                                  color: isActive 
                                      ? Colors.white
                                      : const Color(0xFF223a66),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 48),

                // Doctors Grid
                if (loadingDoctors)
                  const Padding(
                    padding: EdgeInsets.all(64),
                    child: CircularProgressIndicator(color: Color(0xFF23cf7c)),
                  )
                else if (doctors.isEmpty)
                  // Empty State
                  Container(
                    padding: const EdgeInsets.all(64),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 72,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Doctors Available',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please select a different specialty or try again later.',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 :
                                     MediaQuery.of(context).size.width > 800 ? 3 :
                                     MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                    ),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return _buildDoctorCard(doctor);
                    },
                  ),
              ],
            ),
          ),

          // CTA Section
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            child: Column(
              children: [
                const Text(
                  'NEED MEDICAL ASSISTANCE?',
                  style: TextStyle(
                    color: Color(0xFF223a66),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Book Your ',
                        style: TextStyle(
                          color: Color(0xFF223a66),
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Consultation',
                        style: TextStyle(
                          color: Color(0xFF223a66),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Schedule an appointment with our experienced specialists for personalized healthcare solutions.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/booking');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF23cf7c),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 8,
                      ),
                      child: const Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF223a66),
                        side: const BorderSide(
                          color: Color(0xFF223a66),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Image
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://localhost:6868/api/v1/images/view/${doctor.avatar ?? "default.png"}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                // Overlay with contact buttons (shown on hover in web)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF23cf7c),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF223a66),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Doctor Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.medical_services,
                    color: Color(0xFF23cf7c),
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    doctor.bio,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF223a66),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor.specialty?.specialtyName ?? 'Không rõ chuyên khoa',
                    style: const TextStyle(
                      color: Color(0xFF23cf7c),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Experienced healthcare professional',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  // View Profile Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/doctor-detail',
                          arguments: doctor.id,
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('View Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF223a66),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
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
}