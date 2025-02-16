// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/parking_controller.dart';

// class ParkingListScreen extends StatefulWidget {
//   const ParkingListScreen({super.key});

//   @override
//   _ParkingListScreenState createState() => _ParkingListScreenState();
// }

// class _ParkingListScreenState extends State<ParkingListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final parkingController = Provider.of<ParkingController>(context);

//     return Scaffold(
//       body:
//           parkingController.requests.isEmpty
//               ? const Center(child: Text("No parking requests found"))
//               : ListView.builder(
//                 itemCount: parkingController.requests.length,
//                 itemBuilder: (context, index) {
//                   final request = parkingController.requests[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 8,
//                       horizontal: 10,
//                     ),
//                     child: ListTile(
//                       title: Text("${request.name} - ${request.numberPlate}"),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Mobile: ${request.mobile}"),
//                           Text("Address: ${request.address}"),
//                           if (request.isApproved)
//                             Text(
//                               "Allocated: ${request.allocatedSpace}",
//                               style: const TextStyle(color: Colors.green),
//                             ),
//                         ],
//                       ),
//                       trailing: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed:
//                             request.isApproved
//                                 ? null
//                                 : () => _showApprovalDialog(context, index),
//                         child: const Text("Approve & Allocate"),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//     );
//   }

//   void _showApprovalDialog(BuildContext context, int index) {
//     TextEditingController parkingController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Allocate Parking Space"),
//           content: TextField(
//             controller: parkingController,
//             decoration: const InputDecoration(
//               labelText: "Parking Space Number",
//             ),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (parkingController.text.isNotEmpty) {
//                   Provider.of<ParkingController>(
//                     context,
//                     listen: false,
//                   ).approveRequest(index, parkingController.text);

//                   Navigator.pop(context);
//                   _showSuccessDialog(context);
//                 }
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Success"),
//           content: const Text("Parking space allocated successfully!"),
//           actions: [
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
