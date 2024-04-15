class UserLocation {
  double lat;
  double lng;
  String? city;
  String? country;
  String? address;

  UserLocation({
    required this.lat,
    required this.lng,
    this.city,
    this.country,
    this.address,
  });

  // Convert UserLocation object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'city': city,
      'country': country,
      'address': address,
    };
  }

  // Create a UserLocation object from JSON data
  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      lat: json['lat'],
      lng: json['lng'],
      city: json['city'],
      country: json['country'],
      address: json['address'],
    );
  }
}
