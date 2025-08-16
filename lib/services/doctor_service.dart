import '../services/base_service.dart';
import '../models/doctor.dart';

class DoctorService {
  static Future<List<Doctor>> getDoctorsBySpecialty(int specialtyId) async {
    try {
      final response = await BaseService.get('/doctors?specialtyId=$specialtyId&page=0', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['data'] != null && response['data']['data']['doctors'] != null) {
        final List<dynamic> doctorList = response['data']['data']['doctors'];
        return doctorList.map((json) => Doctor.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách bác sĩ: $e');
    }
  }

  static Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await BaseService.get('/doctors', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['data'] != null && response['data']['data']['doctors'] != null) {
        final List<dynamic> doctorList = response['data']['data']['doctors'];
        return doctorList.map((json) => Doctor.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách tất cả bác sĩ: $e');
    }
  }

  static Future<Doctor?> getDoctorDetail(int doctorId) async {
    try {
      final response = await BaseService.get('/doctors/$doctorId', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['data'] != null && response['data']['data']['doctor'] != null) {
        return Doctor.fromJson(response['data']['data']['doctor']);
      }
      
      return null;
    } catch (e) {
      throw Exception('Lỗi khi lấy chi tiết bác sĩ: $e');
    }
  }
}
