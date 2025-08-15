import 'base_service.dart';

class LocationService {
  // Lấy danh sách tỉnh/thành phố
  static Future<Map<String, dynamic>> getProvinces() async {
    return await BaseService.get('/locations/provinces', requireAuth: false);
  }

  // Lấy danh sách quận/huyện theo tỉnh
  static Future<Map<String, dynamic>> getDistricts(int provinceId) async {
    return await BaseService.get('/locations/provinces/$provinceId/districts', requireAuth: false);
  }

  // Lấy danh sách phường/xã theo quận
  static Future<Map<String, dynamic>> getWards(int districtId) async {
    return await BaseService.get('/locations/districts/$districtId/wards', requireAuth: false);
  }

  // Tìm kiếm địa điểm
  static Future<Map<String, dynamic>> searchLocations(String keyword) async {
    return await BaseService.get('/locations/search?keyword=$keyword', requireAuth: false);
  }

  // Lấy thông tin chi tiết địa điểm
  static Future<Map<String, dynamic>> getLocationDetail(int locationId) async {
    return await BaseService.get('/locations/$locationId', requireAuth: false);
  }
}
