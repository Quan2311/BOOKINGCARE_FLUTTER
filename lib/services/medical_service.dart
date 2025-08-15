import 'base_service.dart';

class MedicalService {
  // Lấy danh sách chuyên khoa
  static Future<Map<String, dynamic>> getSpecialties() async {
    final result = await BaseService.get('/specialties', requireAuth: false);
    
    // Handle nested data structure: result['data']['data']['specialtyList']
    if (result['success'] && result['data'] != null) {
      final outerData = result['data'];
      if (outerData['data'] != null && outerData['data']['specialtyList'] != null) {
        // Flatten the structure for easier access
        return {
          'success': true,
          'data': outerData['data']['specialtyList'],
        };
      }
    }
    
    return result;
  }

  // Lấy chi tiết chuyên khoa
  static Future<Map<String, dynamic>> getSpecialtyDetail(int specialtyId) async {
    return await BaseService.get('/specialties/$specialtyId', requireAuth: false);
  }

  // Lấy danh sách bác sĩ
  static Future<Map<String, dynamic>> getDoctors({
    int? specialtyId,
    int? provinceId,
    int page = 1,
    int limit = 10,
  }) async {
    String endpoint = '/doctors?page=$page&limit=$limit';
    if (specialtyId != null) endpoint += '&specialty_id=$specialtyId';
    if (provinceId != null) endpoint += '&province_id=$provinceId';
    
    return await BaseService.get(endpoint, requireAuth: false);
  }

  // Lấy chi tiết bác sĩ
  static Future<Map<String, dynamic>> getDoctorDetail(int doctorId) async {
    return await BaseService.get('/doctors/$doctorId', requireAuth: false);
  }

  // Lấy lịch khám của bác sĩ
  static Future<Map<String, dynamic>> getDoctorSchedule(int doctorId, String date) async {
    return await BaseService.get('/doctors/$doctorId/schedule?date=$date');
  }

  // Lấy danh sách phòng khám
  static Future<Map<String, dynamic>> getClinics({
    int? provinceId,
    int page = 1,
    int limit = 10,
  }) async {
    String endpoint = '/clinics?page=$page&limit=$limit';
    if (provinceId != null) endpoint += '&province_id=$provinceId';
    
    return await BaseService.get(endpoint, requireAuth: false);
  }

  // Lấy chi tiết phòng khám
  static Future<Map<String, dynamic>> getClinicDetail(int clinicId) async {
    return await BaseService.get('/clinics/$clinicId', requireAuth: false);
  }

  // Lấy danh sách gói khám
  static Future<Map<String, dynamic>> getPackages({
    int page = 1,
    int limit = 10,
  }) async {
    return await BaseService.get('/packages?page=$page&limit=$limit', requireAuth: false);
  }

  // Lấy chi tiết gói khám
  static Future<Map<String, dynamic>> getPackageDetail(int packageId) async {
    return await BaseService.get('/packages/$packageId', requireAuth: false);
  }

  // Lấy danh sách bài viết y tế
  static Future<Map<String, dynamic>> getMedicalPosts({
    int? categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    String endpoint = '/medical-posts?page=$page&limit=$limit';
    if (categoryId != null) endpoint += '&category_id=$categoryId';
    
    return await BaseService.get(endpoint, requireAuth: false);
  }

  // Lấy chi tiết bài viết y tế
  static Future<Map<String, dynamic>> getMedicalPostDetail(int postId) async {
    return await BaseService.get('/medical-posts/$postId', requireAuth: false);
  }

  // Tìm kiếm
  static Future<Map<String, dynamic>> search({
    required String keyword,
    String type = 'all', // 'doctor', 'clinic', 'specialty', 'all'
    int page = 1,
    int limit = 10,
  }) async {
    return await BaseService.get('/search?keyword=$keyword&type=$type&page=$page&limit=$limit', requireAuth: false);
  }
}
