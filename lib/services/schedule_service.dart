import '../services/base_service.dart';
import '../models/schedule.dart';

class ScheduleService {
  static Future<List<Schedule>> getSchedulesBySpecialty(String specialtyId) async {
    try {
      final response = await BaseService.get('/schedules?specialtyId=$specialtyId', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['scheduleResponseList'] != null) {
        final List<dynamic> scheduleList = response['data']['scheduleResponseList'];
        return scheduleList.map((json) => Schedule.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy lịch trình: $e');
    }
  }

  static Future<List<Schedule>> getSchedulesByDoctor(int doctorId) async {
    try {
      final response = await BaseService.get('/schedules?doctorId=$doctorId', requireAuth: false);
      
      if (response['success'] && response['data'] != null && response['data']['scheduleResponseList'] != null) {
        final List<dynamic> scheduleList = response['data']['scheduleResponseList'];
        return scheduleList.map((json) => Schedule.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw Exception('Lỗi khi lấy lịch trình bác sĩ: $e');
    }
  }

  static Future<Schedule?> getScheduleDetail(int scheduleId) async {
    try {
      final response = await BaseService.get('/schedules/$scheduleId', requireAuth: false);
      
      if (response['success'] && response['data'] != null) {
        return Schedule.fromJson(response['data']);
      }
      
      return null;
    } catch (e) {
      throw Exception('Lỗi khi lấy chi tiết lịch trình: $e');
    }
  }
}
