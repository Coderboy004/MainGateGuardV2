class ParkingRequest {
  final String name;
  final String numberPlate;
  final String mobile;
  final String address;
  bool isApproved;
  String? allocatedSpace;

  ParkingRequest({
    required this.name,
    required this.numberPlate,
    required this.mobile,
    required this.address,
    this.isApproved = false,
    this.allocatedSpace,
  });
}
