# Services Architecture

Dự án đã được tách API thành các service riêng biệt để dễ quản lý và maintain. Dưới đây là cấu trúc các service:

## Cấu trúc Service

### 1. BaseService (`base_service.dart`)
- Chứa các method HTTP cơ bản (GET, POST, PUT, DELETE)
- Xử lý headers, authentication
- Error handling tập trung

### 2. AuthService (`auth_service.dart`)
- Đăng nhập/đăng ký
- Quản lý token và session
- Đổi mật khẩu, quên mật khẩu
- Kiểm tra trạng thái đăng nhập

### 3. MedicalService (`medical_service.dart`)
- Chuyên khoa, bác sĩ, phòng khám
- Gói khám sức khỏe
- Bài viết y tế
- Tìm kiếm

### 4. BookingService (`booking_service.dart`)
- Đặt lịch hẹn
- Quản lý lịch hẹn (xem, hủy, dời lịch)
- Đánh giá sau khám
- Thanh toán

### 5. UserService (`user_service.dart`)
- Quản lý hồ sơ người dùng
- Thông báo
- Hồ sơ bệnh nhân
- Cài đặt

### 6. LocationService (`location_service.dart`)
- Tỉnh/thành, quận/huyện, phường/xã
- Tìm kiếm địa điểm

## Cách sử dụng

### Import service
```dart
import '../services/auth_service.dart';
import '../services/medical_service.dart';
// hoặc import tất cả
import '../services/index.dart';
```

### Ví dụ sử dụng AuthService
```dart
// Đăng nhập
final result = await AuthService.login(
  phoneNumber: '0123456789',
  password: 'password123',
);

if (result['success']) {
  print('Đăng nhập thành công');
} else {
  print('Lỗi: ${result['message']}');
}

// Kiểm tra đã đăng nhập chưa
final isLoggedIn = await AuthService.isLoggedIn();

// Lấy thông tin user
final user = await AuthService.getCurrentUser();

// Đăng xuất
await AuthService.logout();
```

### Ví dụ sử dụng MedicalService
```dart
// Lấy danh sách chuyên khoa
final specialties = await MedicalService.getSpecialties();

// Lấy danh sách bác sĩ theo chuyên khoa
final doctors = await MedicalService.getDoctors(
  specialtyId: 1,
  page: 1,
  limit: 10,
);

// Tìm kiếm
final searchResult = await MedicalService.search(
  keyword: 'tim mạch',
  type: 'doctor',
);
```

### Ví dụ sử dụng BookingService
```dart
// Đặt lịch hẹn
final booking = await BookingService.createBooking(
  doctorId: 1,
  appointmentDate: '2025-08-15',
  timeSlot: '09:00',
  patientName: 'Nguyễn Văn A',
  patientPhone: '0123456789',
  patientEmail: 'email@example.com',
  birthDate: DateTime(1990, 1, 1),
  gender: 'Nam',
  address: 'Hà Nội',
  reason: 'Khám tổng quát',
);

// Lấy danh sách lịch hẹn
final bookings = await BookingService.getUserBookings(
  status: 'pending',
);

// Hủy lịch hẹn
await BookingService.cancelBooking(1, 'Có việc đột xuất');
```

## Error Handling

Tất cả các service đều trả về cấu trúc response giống nhau:
```dart
{
  'success': bool,
  'data': dynamic,        // Chỉ có khi success = true
  'message': String,      // Thông báo lỗi hoặc thành công
  'statusCode': int,      // HTTP status code (optional)
}
```

## Migration từ ApiService cũ

ApiService cũ vẫn được giữ lại để đảm bảo backward compatibility. Các file cũ có thể được cập nhật dần:

1. Thay `import '../services/api_service.dart';` thành `import '../services/auth_service.dart';`
2. Thay `ApiService.login()` thành `AuthService.login()`
3. Thay `ApiService.getCurrentUser()` thành `AuthService.getCurrentUser()`
4. Và các method tương ứng khác...

## Benefits

- **Tách biệt responsibility**: Mỗi service chỉ quan tâm đến domain riêng
- **Dễ test**: Có thể mock từng service riêng biệt
- **Dễ maintain**: Code được tổ chức rõ ràng
- **Reusable**: Các method có thể được tái sử dụng ở nhiều nơi
- **Type safe**: Cấu trúc response nhất quán
