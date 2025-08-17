class Schedule {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final int bookingLimit;
  final int numberBooked;
  final int doctorId;
  final int clinicId;
  final dynamic dateSchedule; // Can be string or List
  final bool active;
  final double? price;

  Schedule({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingLimit,
    required this.numberBooked,
    required this.doctorId,
    required this.clinicId,
    this.dateSchedule,
    this.active = true,
    this.price,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      bookingLimit: json['bookingLimit'] ?? 0,
      numberBooked: json['numberBooked'] ?? 0,
      doctorId: json['doctorId'] ?? 0,
      clinicId: json['clinicId'] ?? 0,
      dateSchedule: json['dateSchedule'],
      active: json['active'] ?? true,
      price: json['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'bookingLimit': bookingLimit,
      'numberBooked': numberBooked,
      'doctorId': doctorId,
      'clinicId': clinicId,
      'dateSchedule': dateSchedule,
      'active': active,
      'price': price,
    };
  }
}
