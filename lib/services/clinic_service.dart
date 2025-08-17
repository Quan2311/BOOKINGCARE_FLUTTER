import '../services/base_service.dart';
import '../models/clinic.dart';

class ClinicService {
  static Future<List<Clinic>> getClinicsBySpecialty(String specialtyId) async {
    try {
      final response = await BaseService.get('/clinics?specialtyId=$specialtyId', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['clinicList'] != null) {
        final List<dynamic> clinicList = response['data']['clinicList'];
        return clinicList.map((json) => Clinic.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách phòng khám: $e');
    }
  }

  static Future<Clinic?> getClinicDetail(int clinicId) async {
    try {
      final response = await BaseService.get('/clinics/$clinicId', requireAuth: false);
      
      if (response['success'] && response['data'] != null) {
        return Clinic.fromJson(response['data']);
      }
      
      return null;
    } catch (e) {
      throw Exception('Lỗi khi lấy chi tiết phòng khám: $e');
    }
  }

  static Future<List<Clinic>> getAllClinics() async {
    try {
      final response = await BaseService.get('/clinics', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['clinicList'] != null) {
        final List<dynamic> clinicList = response['data']['clinicList'];
        return clinicList.map((json) => Clinic.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách tất cả phòng khám: $e');
    }
  }
}
