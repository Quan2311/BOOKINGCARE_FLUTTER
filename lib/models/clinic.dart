class Clinic {
  final int id;
  final String clinicName;
  final String address;
  final String description;
  final String clinicImage;
  final String phone;
  final double? latitude;
  final double? longitude;

  Clinic({
    required this.id,
    required this.clinicName,
    required this.address,
    required this.description,
    required this.clinicImage,
    required this.phone,
    this.latitude,
    this.longitude,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'] ?? 0,
      clinicName: json['clinicName'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      clinicImage: json['clinicImage'] ?? '',
      phone: json['phone'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clinicName': clinicName,
      'address': address,
      'description': description,
      'clinicImage': clinicImage,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
