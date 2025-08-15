class Specialty {
  final int id;
  final String specialtyName;
  final String description;
  final String specialtyImage;
  final double price;

  Specialty({
    required this.id,
    required this.specialtyName,
    required this.description,
    required this.specialtyImage,
    required this.price,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['id'] ?? 0,
      specialtyName: json['specialtyName'] ?? '',
      description: json['description'] ?? '',
      specialtyImage: json['specialtyImage'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialtyName': specialtyName,
      'description': description,
      'specialtyImage': specialtyImage,
      'price': price,
    };
  }
}