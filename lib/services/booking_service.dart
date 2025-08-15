import 'base_service.dart';

class BookingService {
  // Tạo lịch hẹn mới
  static Future<Map<String, dynamic>> createBooking({
    required int doctorId,
    required String appointmentDate,
    required String timeSlot,
    required String patientName,
    required String patientPhone,
    required String patientEmail,
    required DateTime birthDate,
    required String gender,
    required String address,
    required String reason,
    int? clinicId,
    int? packageId,
  }) async {
    return await BaseService.post('/bookings', {
      'doctor_id': doctorId,
      'appointment_date': appointmentDate,
      'time_slot': timeSlot,
      'patient_name': patientName,
      'patient_phone': patientPhone,
      'patient_email': patientEmail,
      'birth_date': birthDate.toIso8601String(),
      'gender': gender,
      'address': address,
      'reason': reason,
      if (clinicId != null) 'clinic_id': clinicId,
      if (packageId != null) 'package_id': packageId,
    });
  }

  // Lấy danh sách lịch hẹn của user
  static Future<Map<String, dynamic>> getUserBookings({
    String status = 'all', // 'pending', 'confirmed', 'completed', 'cancelled', 'all'
    int page = 1,
    int limit = 10,
  }) async {
    String endpoint = '/bookings/user?page=$page&limit=$limit';
    if (status != 'all') endpoint += '&status=$status';
    
    return await BaseService.get(endpoint);
  }

  // Lấy chi tiết lịch hẹn
  static Future<Map<String, dynamic>> getBookingDetail(int bookingId) async {
    return await BaseService.get('/bookings/$bookingId');
  }

  // Hủy lịch hẹn
  static Future<Map<String, dynamic>> cancelBooking(int bookingId, String reason) async {
    return await BaseService.put('/bookings/$bookingId/cancel', {
      'cancel_reason': reason,
    });
  }

  // Xác nhận lịch hẹn (cho bác sĩ/admin)
  static Future<Map<String, dynamic>> confirmBooking(int bookingId) async {
    return await BaseService.put('/bookings/$bookingId/confirm', {});
  }

  // Hoàn thành lịch hẹn (cho bác sĩ)
  static Future<Map<String, dynamic>> completeBooking(int bookingId, {
    String? diagnosis,
    String? prescription,
    String? notes,
  }) async {
    return await BaseService.put('/bookings/$bookingId/complete', {
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (prescription != null) 'prescription': prescription,
      if (notes != null) 'notes': notes,
    });
  }

  // Đặt lại lịch hẹn
  static Future<Map<String, dynamic>> rescheduleBooking({
    required int bookingId,
    required String newDate,
    required String newTimeSlot,
    String? reason,
  }) async {
    return await BaseService.put('/bookings/$bookingId/reschedule', {
      'new_date': newDate,
      'new_time_slot': newTimeSlot,
      if (reason != null) 'reason': reason,
    });
  }

  // Lấy thống kê lịch hẹn
  static Future<Map<String, dynamic>> getBookingStats() async {
    return await BaseService.get('/bookings/stats');
  }

  // Đánh giá sau khi khám
  static Future<Map<String, dynamic>> rateBooking({
    required int bookingId,
    required int rating, // 1-5
    String? review,
  }) async {
    return await BaseService.post('/bookings/$bookingId/rate', {
      'rating': rating,
      if (review != null) 'review': review,
    });
  }

  // Lấy danh sách đánh giá của bác sĩ
  static Future<Map<String, dynamic>> getDoctorReviews(int doctorId, {
    int page = 1,
    int limit = 10,
  }) async {
    return await BaseService.get('/doctors/$doctorId/reviews?page=$page&limit=$limit', requireAuth: false);
  }

  // Thanh toán lịch hẹn
  static Future<Map<String, dynamic>> processPayment({
    required int bookingId,
    required String paymentMethod, // 'cash', 'card', 'momo', 'zalopay'
    double? amount,
  }) async {
    return await BaseService.post('/bookings/$bookingId/payment', {
      'payment_method': paymentMethod,
      if (amount != null) 'amount': amount,
    });
  }

  // Lấy lịch sử thanh toán
  static Future<Map<String, dynamic>> getPaymentHistory({
    int page = 1,
    int limit = 10,
  }) async {
    return await BaseService.get('/payments/history?page=$page&limit=$limit');
  }
}
