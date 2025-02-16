class Profile {
  final String name;
  final String address;
  final String contactNo;
  final String alternateContactNo;
  final String? imagePath; // Optional profile image

  Profile({
    required this.name,
    required this.address,
    required this.contactNo,
    required this.alternateContactNo,
    this.imagePath,
  });
}