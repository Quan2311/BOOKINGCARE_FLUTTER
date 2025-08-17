import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/specialty.dart';
import '../models/clinic.dart';
import '../models/doctor.dart';
import '../models/schedule.dart';
import '../services/medical_service.dart';
import '../services/clinic_service.dart';
import '../services/doctor_service.dart';
import '../services/schedule_service.dart';
import '../services/booking_service.dart';

class MedicalServiceDetailPage extends StatefulWidget {
  final String? idNameSpecialty;

  const MedicalServiceDetailPage({super.key, this.idNameSpecialty});

  @override
  State<MedicalServiceDetailPage> createState() => _MedicalServiceDetailPageState();
}

class _MedicalServiceDetailPageState extends State<MedicalServiceDetailPage> {
  Specialty? specialty;
  List<Clinic> clinics = [];
  List<Doctor> doctors = [];
  List<Schedule> schedules = [];
  bool loading = true;
  String? specialtyId;

  @override
  void initState() {
    super.initState();
    // Extract ID from route arguments or widget parameter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic>) {
        specialtyId = arguments['id']?.toString();
        print('Medical Detail: Got ID from route arguments: $specialtyId');
      } else if (widget.idNameSpecialty != null) {
        specialtyId = widget.idNameSpecialty!.contains('-') 
            ? widget.idNameSpecialty!.split('-')[0]
            : widget.idNameSpecialty;
        print('Medical Detail: Got ID from widget parameter: $specialtyId');
      }
      
      if (specialtyId != null) {
        print('Medical Detail: Starting to fetch data for specialty ID: $specialtyId');
        fetchData();
      } else {
        print('Medical Detail: No specialty ID found!');
      }
    });
  }

  Future<void> fetchData() async {
    if (specialtyId == null) return;
    
    setState(() {
      loading = true;
    });

    try {
      await Future.wait([
        fetchSpecialty(),
        fetchClinics(),
        fetchDoctors(),
        fetchSchedules(),
      ]);
    } catch (error) {
      print("Error fetching data: $error");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchSpecialty() async {
    try {
      print('Medical Detail: Fetching specialty data for ID: $specialtyId');
      final response = await MedicalService.getSpecialtyDetail(int.parse(specialtyId!));
      print('Medical Detail: API Response: $response');
      
      if (response['success'] && response['data'] != null) {
        final specialtyData = Specialty.fromJson(response['data']);
        print('Medical Detail: Parsed specialty: ${specialtyData.specialtyName}');
        print('Medical Detail: Specialty description: ${specialtyData.description}');
        print('Medical Detail: Specialty price: ${specialtyData.price}');
        print('Medical Detail: Specialty image: ${specialtyData.specialtyImage}');
        
        setState(() {
          specialty = specialtyData;
        });
      } else {
        print('Medical Detail: API failed - success: ${response['success']}, data: ${response['data']}');
      }
    } catch (e) {
      print("Medical Detail: Error fetching specialty: $e");
    }
  }

  Future<void> fetchClinics() async {
    try {
      final clinicList = await ClinicService.getClinicsBySpecialty(specialtyId!);
      setState(() {
        clinics = clinicList;
      });
    } catch (e) {
      print("Error fetching clinics: $e");
    }
  }

  Future<void> fetchDoctors() async {
    try {
      final doctorList = await DoctorService.getDoctorsBySpecialty(int.parse(specialtyId!));
      setState(() {
        doctors = doctorList;
      });
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  Future<void> fetchSchedules() async {
    try {
      final scheduleList = await ScheduleService.getSchedulesBySpecialty(specialtyId!);
      setState(() {
        schedules = scheduleList;
      });
    } catch (e) {
      print("Error fetching schedules: $e");
    }
  }

  Future<void> handleBooking(Schedule schedule, Doctor doctor) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        Fluttertoast.showToast(
          msg: "Bạn cần đăng nhập để đặt lịch.",
          backgroundColor: Colors.red,
        );
        return;
      }

      final result = await BookingService.createBooking(
        doctorId: doctor.id,
        appointmentDate: schedule.date,
        timeSlot: '${schedule.startTime} - ${schedule.endTime}',
        patientName: 'Patient', // Will be updated from user profile
        patientPhone: '0123456789', // Will be updated from user profile
        patientEmail: 'patient@email.com', // Will be updated from user profile
        birthDate: DateTime.now().subtract(Duration(days: 365 * 25)), // Default
        gender: 'Male', // Default
        address: 'Address', // Will be updated from user profile
        reason: 'Medical consultation',
        clinicId: schedule.clinicId,
      );
      
      if (result['success']) {
        Fluttertoast.showToast(
          msg: "Đặt lịch thành công!",
          backgroundColor: Colors.green,
        );
        // Refresh schedules to update available slots
        await fetchSchedules();
      } else {
        Fluttertoast.showToast(
          msg: result['message'] ?? "Có lỗi xảy ra khi đặt lịch",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Lỗi: $e",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF23cf7c)),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
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
                // Background image
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
                          'MEDICAL DEPARTMENT',
                          style: TextStyle(
                            color: Color(0xFF87CEEB),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          specialty?.specialtyName ?? 'Specialty',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Expert care and advanced treatment options',
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
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description Section
                    Expanded(
                      flex: 2,
                      child: Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Specialty Image
                            if (specialty?.specialtyImage != null)
                              Container(
                                margin: const EdgeInsets.only(bottom: 32),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    'http://localhost:6868/uploads/${specialty!.specialtyImage}',
                                    width: double.infinity,
                                    height: 320,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading specialty image: $error');
                                      return Container(
                                        width: double.infinity,
                                        height: 320,
                                        color: Colors.grey[200],
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image_not_supported, 
                                                size: 50, color: Colors.grey),
                                            SizedBox(height: 8),
                                            Text('Image not available', 
                                                style: TextStyle(color: Colors.grey)),
                                          ],
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: double.infinity,
                                        height: 320,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            
                            // Section Header
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ABOUT DEPARTMENT',
                                  style: TextStyle(
                                    color: Color(0xFF223a66),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  specialty?.specialtyName ?? 'Specialty Overview',
                                  style: const TextStyle(
                                    color: Color(0xFF223a66),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            
                            // Description
                            Text(
                              specialty?.description ?? 'No description available for this specialty.',
                              style: TextStyle(
                                color: specialty?.description != null 
                                    ? Colors.black87 
                                    : Colors.grey[500],
                                fontSize: 16,
                                height: 1.6,
                                fontStyle: specialty?.description != null 
                                    ? FontStyle.normal 
                                    : FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),

                    // Schedule & Info Sidebar
                    Expanded(
                      flex: 1,
                      child: Container(
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
                            // Header
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF223a66), Color(0xFF2c4a7a)],
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.schedule, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Schedule & Information',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Content
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  // Working Hours
                                  _buildInfoSection(
                                    'Working Hours',
                                    Icons.schedule,
                                    [
                                      ['Monday - Friday', '7:00 - 17:00'],
                                      ['Saturday', '7:00 - 16:00'],
                                      ['Sunday', 'Closed'],
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  
                                  // Consultation Fee
                                  _buildPriceSection(),
                                  const SizedBox(height: 32),
                                  
                                  // Locations
                                  _buildLocationSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Doctors Section
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'OUR MEDICAL TEAM',
                            style: TextStyle(
                              color: Color(0xFF223a66),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Expert ',
                                  style: TextStyle(
                                    color: Color(0xFF223a66),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Doctors',
                                  style: TextStyle(
                                    color: Color(0xFF223a66),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Meet our experienced medical professionals specialized in this department',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Doctors List
                      if (doctors.isEmpty)
                        _buildNoDoctorsSection()
                      else
                        Column(
                          children: doctors.map((doctor) => 
                            _buildDoctorCard(doctor)).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, List<List<String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF23cf7c), size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF223a66),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...items.map((item) => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item[0],
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                item[1],
                style: const TextStyle(
                  color: Color(0xFF223a66),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.attach_money, color: Color(0xFF23cf7c), size: 18),
            SizedBox(width: 8),
            Text(
              'Consultation Fee',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF223a66),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF23cf7c).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF23cf7c).withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Text(
                '\$${specialty?.price ?? "Contact us"}',
                style: const TextStyle(
                  color: Color(0xFF23cf7c),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Starting from',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.location_on, color: Color(0xFF23cf7c), size: 18),
            SizedBox(width: 8),
            Text(
              'Our Locations',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF223a66),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (clinics.isEmpty)
          const Text(
            'Locations updating...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          )
        else
          ...clinics.map((clinic) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinic.clinicName ?? 'Clinic',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF223a66),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  clinic.address ?? 'Address updating...',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )).toList(),
      ],
    );
  }

  Widget _buildNoDoctorsSection() {
    return Container(
      padding: const EdgeInsets.all(48),
      child: const Column(
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 72,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No Doctors Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Currently no doctors are assigned to this specialty.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    // Filter schedules for this doctor
    final doctorSchedules = schedules.where((s) {
      final now = DateTime.now();
      final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      
      // Parse schedule date
      String scheduleDate;
      if (s.dateSchedule is List) {
        scheduleDate = (s.dateSchedule as List).join('-');
      } else {
        scheduleDate = s.dateSchedule.toString();
      }
      
      // Parse schedule time
      String startTime;
      if (s.startTime is List) {
        startTime = (s.startTime as List).join(':');
      } else {
        startTime = s.startTime.toString();
      }
      
      try {
        final scheduleDateTime = DateTime.parse('${scheduleDate}T$startTime');
        return s.doctorId == doctor.id &&
               scheduleDate == today &&
               s.active &&
               scheduleDateTime.isAfter(now);
      } catch (e) {
        return false;
      }
    }).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: doctor.avatar != null
                      ? NetworkImage(
                          'http://localhost:6868/uploads/${doctor.avatar}',
                        )
                      : const AssetImage('assets/images/doctor.png') as ImageProvider,
                  backgroundColor: const Color(0xFF23cf7c),
                  onBackgroundImageError: doctor.avatar != null 
                      ? (exception, stackTrace) {
                          print('Error loading doctor avatar: $exception');
                        }
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  doctor.user?.fullname ?? 'Doctor',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223a66),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${specialty?.specialtyName} Specialist',
                  style: const TextStyle(
                    color: Color(0xFF23cf7c),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/doctor-detail',
                      arguments: doctor.id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF223a66),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('View Profile'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Doctor Details
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Doctor Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF223a66),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDoctorInfo(Icons.email, doctor.user?.email ?? ''),
                _buildDoctorInfo(Icons.phone, doctor.user?.phoneNumber ?? ''),
                _buildDoctorInfo(
                  doctor.user?.gender == 'Male' ? Icons.male : Icons.female,
                  doctor.user?.gender ?? '',
                ),
                _buildDoctorInfo(Icons.cake, doctor.user?.birthday ?? ''),
                _buildDoctorInfo(Icons.military_tech, '${doctor.experience ?? 0} years experience'),
                if (doctor.qualification != null)
                  _buildDoctorInfo(Icons.school, doctor.qualification!),
                if (doctor.bio != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    '"${doctor.bio}"',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Schedule
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.calendar_today, color: Color(0xFF23cf7c), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Available Times',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF223a66),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (doctorSchedules.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'No available slots',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Please check back later',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: doctorSchedules.length,
                    itemBuilder: (context, index) {
                      final schedule = doctorSchedules[index];
                      final availableSlots = schedule.bookingLimit - schedule.numberBooked;
                      
                      return ElevatedButton(
                        onPressed: () => handleBooking(schedule, doctor),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF23cf7c).withOpacity(0.1),
                          foregroundColor: const Color(0xFF23cf7c),
                          side: const BorderSide(color: Color(0xFF23cf7c), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${schedule.startTime.toString().substring(0, 5)} - ${schedule.endTime.toString().substring(0, 5)}',
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '$availableSlots slots left',
                              style: TextStyle(fontSize: 8, color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF23cf7c), size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}