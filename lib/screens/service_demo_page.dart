import 'package:flutter/material.dart';
import '../services/medical_service.dart';
import '../services/booking_service.dart';
import '../services/user_service.dart';

class ServiceDemoPage extends StatefulWidget {
  const ServiceDemoPage({super.key});

  @override
  State<ServiceDemoPage> createState() => _ServiceDemoPageState();
}

class _ServiceDemoPageState extends State<ServiceDemoPage> {
  List<dynamic> specialties = [];
  List<dynamic> doctors = [];
  List<dynamic> bookings = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      // Demo MedicalService
      final specialtyResult = await MedicalService.getSpecialties();
      if (specialtyResult['success']) {
        setState(() => specialties = specialtyResult['data']['specialties'] ?? []);
      }

      final doctorResult = await MedicalService.getDoctors(page: 1, limit: 5);
      if (doctorResult['success']) {
        setState(() => doctors = doctorResult['data']['doctors'] ?? []);
      }

      // Demo BookingService
      final bookingResult = await BookingService.getUserBookings();
      if (bookingResult['success']) {
        setState(() => bookings = bookingResult['data']['bookings'] ?? []);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi tải dữ liệu: $e')),
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> _searchDoctors() async {
    final result = await MedicalService.search(
      keyword: 'tim mạch',
      type: 'doctor',
    );

    if (result['success'] && mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Kết quả tìm kiếm'),
          content: Text('Tìm thấy ${result['data']['total'] ?? 0} bác sĩ'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _getUserProfile() async {
    final result = await UserService.getUserProfile();
    
    if (result['success'] && mounted) {
      final user = result['data']['user'];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Thông tin người dùng'),
          content: Text('''
Tên: ${user['full_name'] ?? 'N/A'}
Email: ${user['email'] ?? 'N/A'}
Điện thoại: ${user['phone_number'] ?? 'N/A'}
          '''),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Không thể tải thông tin')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Services'),
        backgroundColor: const Color(0xFF223a66),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Demo buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _searchDoctors,
                          child: const Text('Tìm kiếm bác sĩ'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _getUserProfile,
                          child: const Text('Xem profile'),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),

                  // Specialties section
                  const Text(
                    'Chuyên khoa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: specialties.length,
                      itemBuilder: (context, index) {
                        final specialty = specialties[index];
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 12),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  const Icon(Icons.medical_services, size: 32),
                                  const SizedBox(height: 8),
                                  Text(
                                    specialty['name'] ?? 'Chuyên khoa',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Doctors section
                  const Text(
                    'Bác sĩ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(doctor['full_name']?[0] ?? 'D'),
                          ),
                          title: Text(doctor['full_name'] ?? 'Bác sĩ'),
                          subtitle: Text(doctor['specialty_name'] ?? 'Chuyên khoa'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Bookings section
                  const Text(
                    'Lịch hẹn gần đây',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  bookings.isEmpty
                      ? const Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Bạn chưa có lịch hẹn nào',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            return Card(
                              child: ListTile(
                                title: Text(booking['doctor_name'] ?? 'Bác sĩ'),
                                subtitle: Text(
                                  '${booking['appointment_date']} - ${booking['time_slot']}',
                                ),
                                trailing: Chip(
                                  label: Text(booking['status'] ?? 'pending'),
                                  backgroundColor: _getStatusColor(booking['status']),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'confirmed':
        return Colors.green.shade100;
      case 'completed':
        return Colors.blue.shade100;
      case 'cancelled':
        return Colors.red.shade100;
      default:
        return Colors.orange.shade100;
    }
  }
}
