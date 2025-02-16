class Taxi {
  final String name;
  final String phone;
  final String address;
  final String landmark;
  final String pincode;
  final String state;
  final String city;
  final String? imagePath;
  final String vehicleNumber;

  Taxi({
    required this.name,
    required this.phone,
    required this.address,
    required this.landmark,
    required this.pincode,
    required this.state,
    required this.city,
    this.imagePath,
    required this.vehicleNumber,
  });
}