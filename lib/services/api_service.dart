import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:6868/api/v1';
  
  // Headers mặc định
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
  };

  // Headers với token
  static Future<Map<String, String>> get authHeaders async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Đăng nhập
  static Future<Map<String, dynamic>> login({
    required String phoneNumber,
    required String password,
    int roleId = 3,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: defaultHeaders,
        body: jsonEncode({
          'phone_number': phoneNumber,
          'password': password,
          'role_id': roleId,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        // Lưu token và user info
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token'] ?? '');
        await prefs.setString('user', jsonEncode(data['user'] ?? {}));
        
        return {
          'success': true,
          'data': data,
          'message': 'Đăng nhập thành công!'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Sai thông tin đăng nhập!'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối. Vui lòng kiểm tra mạng và thử lại!'
      };
    }
  }

  // Đăng ký
  static Future<Map<String, dynamic>> register({
    required String phoneNumber,
    required String password,
    required String fullName,
    String? email,
    int roleId = 3,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: defaultHeaders,
        body: jsonEncode({
          'phone_number': phoneNumber,
          'password': password,
          'full_name': fullName,
          'email': email,
          'role_id': roleId,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': data,
          'message': 'Đăng ký thành công!'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Đăng ký thất bại!'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối. Vui lòng kiểm tra mạng và thử lại!'
      };
    }
  }

  // Lấy thông tin user hiện tại
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString('user');
      if (userString != null) {
        return jsonDecode(userString);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Đăng xuất
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  // Kiểm tra đã đăng nhập chưa
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  // GET request với auth
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: await authHeaders,
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Có lỗi xảy ra!'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối mạng!'
      };
    }
  }

  // POST request với auth
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await authHeaders,
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Có lỗi xảy ra!'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối mạng!'
      };
    }
  }
}
