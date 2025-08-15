import 'base_service.dart';

class UserService {
  // Lấy thông tin hồ sơ user
  static Future<Map<String, dynamic>> getUserProfile() async {
    return await BaseService.get('/users/profile');
  }

  // Cập nhật thông tin hồ sơ
  static Future<Map<String, dynamic>> updateProfile({
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    String? gender,
    String? address,
    String? avatar,
  }) async {
    final Map<String, dynamic> data = {};
    
    if (fullName != null) data['full_name'] = fullName;
    if (email != null) data['email'] = email;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (birthDate != null) data['birth_date'] = birthDate.toIso8601String();
    if (gender != null) data['gender'] = gender;
    if (address != null) data['address'] = address;
    if (avatar != null) data['avatar'] = avatar;
    
    return await BaseService.put('/users/profile', data);
  }

  // Upload avatar
  static Future<Map<String, dynamic>> uploadAvatar(String imagePath) async {
    // TODO: Implement multipart file upload
    return {
      'success': false,
      'message': 'Chức năng upload avatar chưa được triển khai'
    };
  }

  // Lấy danh sách bệnh nhân (cho bác sĩ)
  static Future<Map<String, dynamic>> getPatients({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    String endpoint = '/users/patients?page=$page&limit=$limit';
    if (search != null) endpoint += '&search=$search';
    
    return await BaseService.get(endpoint);
  }

  // Lấy chi tiết bệnh nhân
  static Future<Map<String, dynamic>> getPatientDetail(int patientId) async {
    return await BaseService.get('/users/patients/$patientId');
  }

  // Lấy lịch sử khám bệnh của bệnh nhân
  static Future<Map<String, dynamic>> getPatientMedicalHistory(int patientId, {
    int page = 1,
    int limit = 10,
  }) async {
    return await BaseService.get('/users/patients/$patientId/medical-history?page=$page&limit=$limit');
  }

  // Thêm hồ sơ bệnh nhân mới
  static Future<Map<String, dynamic>> addPatientRecord({
    required String fullName,
    required String phoneNumber,
    required DateTime birthDate,
    required String gender,
    required String address,
    String? email,
    String? medicalHistory,
    String? allergies,
  }) async {
    return await BaseService.post('/users/patients', {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'birth_date': birthDate.toIso8601String(),
      'gender': gender,
      'address': address,
      if (email != null) 'email': email,
      if (medicalHistory != null) 'medical_history': medicalHistory,
      if (allergies != null) 'allergies': allergies,
    });
  }

  // Cập nhật hồ sơ bệnh nhân
  static Future<Map<String, dynamic>> updatePatientRecord(int patientId, Map<String, dynamic> data) async {
    return await BaseService.put('/users/patients/$patientId', data);
  }

  // Lấy thông báo của user
  static Future<Map<String, dynamic>> getNotifications({
    bool unreadOnly = false,
    int page = 1,
    int limit = 20,
  }) async {
    String endpoint = '/users/notifications?page=$page&limit=$limit';
    if (unreadOnly) endpoint += '&unread_only=true';
    
    return await BaseService.get(endpoint);
  }

  // Đánh dấu thông báo đã đọc
  static Future<Map<String, dynamic>> markNotificationAsRead(int notificationId) async {
    return await BaseService.put('/users/notifications/$notificationId/read', {});
  }

  // Đánh dấu tất cả thông báo đã đọc
  static Future<Map<String, dynamic>> markAllNotificationsAsRead() async {
    return await BaseService.put('/users/notifications/mark-all-read', {});
  }

  // Xóa thông báo
  static Future<Map<String, dynamic>> deleteNotification(int notificationId) async {
    return await BaseService.delete('/users/notifications/$notificationId');
  }

  // Cập nhật cài đặt thông báo
  static Future<Map<String, dynamic>> updateNotificationSettings({
    bool? emailNotification,
    bool? smsNotification,
    bool? pushNotification,
    bool? appointmentReminder,
    bool? promotionNotification,
  }) async {
    final Map<String, dynamic> settings = {};
    
    if (emailNotification != null) settings['email_notification'] = emailNotification;
    if (smsNotification != null) settings['sms_notification'] = smsNotification;
    if (pushNotification != null) settings['push_notification'] = pushNotification;
    if (appointmentReminder != null) settings['appointment_reminder'] = appointmentReminder;
    if (promotionNotification != null) settings['promotion_notification'] = promotionNotification;
    
    return await BaseService.put('/users/notification-settings', settings);
  }

  // Lấy cài đặt thông báo
  static Future<Map<String, dynamic>> getNotificationSettings() async {
    return await BaseService.get('/users/notification-settings');
  }
}
