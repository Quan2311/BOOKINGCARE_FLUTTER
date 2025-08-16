import 'specialty.dart';

class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String bio;
  final String? avatar;
  final Specialty? specialty;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.bio,
    this.avatar,
    this.specialty,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      bio: json['bio'] ?? '',
      avatar: json['avatar'],
      specialty: json['specialty'] != null 
          ? Specialty.fromJson(json['specialty'])
          : null,
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'avatar': avatar,
      'specialty': specialty?.toJson(),
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}