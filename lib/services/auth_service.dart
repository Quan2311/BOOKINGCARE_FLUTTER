import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_service.dart';

class AuthService {
  // Đăng nhập
  static Future<Map<String, dynamic>> login({
    required String phoneNumber,
    required String password,
    int roleId = 3,
  }) async {
    try {
      final result = await BaseService.post(
        '/users/login',
        {
          'phone_number': phoneNumber,
          'password': password,
          'role_id': roleId,
        },
        requireAuth: false,
      );

      if (result['success']) {
        // Lưu token và user info
        final data = result['data'];
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
          'message': result['message'] ?? 'Sai thông tin đăng nhập!'
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
      final result = await BaseService.post(
        '/users/register',
        {
          'phone_number': phoneNumber,
          'password': password,
          'full_name': fullName,
          'email': email,
          'role_id': roleId,
        },
        requireAuth: false,
      );

      if (result['success']) {
        return {
          'success': true,
          'data': result['data'],
          'message': 'Đăng ký thành công!'
        };
      } else {
        return {
          'success': false,
          'message': result['message'] ?? 'Đăng ký thất bại!'
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

  // Cập nhật thông tin user
  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> userData) async {
    return await BaseService.put('/users/profile', userData);
  }

  // Đổi mật khẩu
  static Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await BaseService.put('/users/change-password', {
      'old_password': oldPassword,
      'new_password': newPassword,
    });
  }

  // Quên mật khẩu
  static Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    return await BaseService.post(
      '/users/forgot-password', 
      {'phone_number': phoneNumber},
      requireAuth: false,
    );
  }

  // Reset mật khẩu
  static Future<Map<String, dynamic>> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    return await BaseService.post(
      '/users/reset-password',
      {
        'phone_number': phoneNumber,
        'otp': otp,
        'new_password': newPassword,
      },
      requireAuth: false,
    );
  }
}
