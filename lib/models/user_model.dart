class UserModel {
  final String? userId;
  final String name;
  final String email;
  final String? image;
  final double lng;
  final double lat;
  final String addres;

  UserModel({
    this.userId,
    required this.name,
    required this.email,
    this.image,
    required this.lng,
    required this.lat,
    required this.addres,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      lng: json['lng'],
      lat: json['lat'],
      addres: json['addres'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'image': image,
      'lng': lng,
      'lat': lat,
      'addres': addres,
    };
  }
}
