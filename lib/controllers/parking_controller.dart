import 'package:flutter/material.dart';
import 'package:maingateguard/models/parking_models.dart';

class ParkingController extends ChangeNotifier {
  final List<ParkingRequest> _requests = [
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "John Doe",
      numberPlate: "MH12 AB 1234",
      mobile: "9876543210",
      address: "Flat 101",
    ),
    ParkingRequest(
      name: "Alice Smith",
      numberPlate: "MH01 XY 5678",
      mobile: "9876543211",
      address:
          "Flat 701, Bachraj Residency GLobal CIty Virar west, Mumbai 401303",
    ),
  ];

  List<ParkingRequest> get requests => _requests;

  void approveRequest(int index, String spaceNumber) {
    _requests[index].isApproved = true;
    _requests[index].allocatedSpace = spaceNumber;
    notifyListeners();
  }
}
