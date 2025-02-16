import 'package:flutter/material.dart';
import 'package:maingateguard/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../controllers/parking_controller.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final parkingController = Provider.of<ParkingController>(context);

    // Filter the list based on search query
    final filteredRequests =
        parkingController.requests.where((request) {
          final query = searchQuery.toLowerCase();
          return request.name.toLowerCase().contains(query) ||
              request.numberPlate.toLowerCase().contains(query) ||
              request.mobile.contains(query) ||
              request.address.toLowerCase().contains(query) ||
              request.allocatedSpace.toString().contains(query);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Requests"),
        backgroundColor: const Color(0xFF6200EE),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              style: TextStyle(color: AppColors.primary1),
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by Name, Number Plate, Mobile, Address...",
                prefixIcon: const Icon(Icons.search, color: AppColors.primary1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary1),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 📜 List of Parking Requests
          Expanded(
            child:
                filteredRequests.isEmpty
                    ? const Center(
                      child: Text("No matching parking requests found"),
                    )
                    : ListView.builder(
                      itemCount: filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = filteredRequests[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          child: ListTile(
                            title: Text("Name: ${request.name}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Vehicle No: ${request.numberPlate}"),
                                Text("Mobile: ${request.mobile}"),
                                Text("Address: ${request.address}"),
                                if (request.isApproved)
                                  Text(
                                    "Allocated: ${request.allocatedSpace}",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    request.isApproved == true
                                        ? Colors
                                            .green // ✅ Green when approved
                                        : AppColors
                                            .primary1, // 🔵 Default primary color
                                foregroundColor: Colors.white,
                              ),
                              onPressed:
                                  request.isApproved
                                      ? null
                                      : () =>
                                          _showApprovalDialog(context, index),
                              child:
                                  (request.isApproved)
                                      ? const Text("Approved & Allocated")
                                      : const Text("Approve & Allocate"),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  void _showApprovalDialog(BuildContext context, int index) {
    TextEditingController parkingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Allocate Parking Space"),
          content: TextField(
            controller: parkingController,
            style: TextStyle(color: AppColors.primary1),
            decoration: const InputDecoration(
              labelText: "Parking Space Number",
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (parkingController.text.isNotEmpty) {
                  Provider.of<ParkingController>(
                    context,
                    listen: false,
                  ).approveRequest(index, parkingController.text);

                  Navigator.pop(context);
                  _showSuccessDialog(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text(
            "Parking space allocated successfully!",
            style: TextStyle(color: AppColors.primary1),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
