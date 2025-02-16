
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light, // Set default theme to light
//         fontFamily: 'Arial',
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6200EE)),
//         useMaterial3: true,
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//             color: Color(0xffffffff), // Light mode text color
//           ),
//           bodyMedium: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.normal,
//             color: Color(0xffffffff),
//           ),
//           bodySmall: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.normal,
//             color: Color(0xffffffff),
//           ),
//         ),
//       ),
//       home: MainGateGuardScreen(),
//     );
//   }
// }

// class MainGateGuardScreen extends StatefulWidget {
//   const MainGateGuardScreen({super.key});

//   @override
//   State<MainGateGuardScreen> createState() => _MainGateGuardScreenState();
// }

// class _MainGateGuardScreenState extends State<MainGateGuardScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   XFile? _profileImage;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   void _pickProfileImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//       });
//     }
//   }

//   void _navigateToEditProfile() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const EditProfileScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF6200EE),
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.white),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         actions: [
//           // Profile Icon
//           GestureDetector(
//             onTap: _navigateToEditProfile,
//             child: CircleAvatar(
//               backgroundImage: _profileImage != null
//                   ? FileImage(File(_profileImage!.path))
//                   : null,
//               backgroundColor: Colors.white,
//               child: _profileImage == null
//                   ? const Icon(Icons.person, color: Colors.deepPurple)
//                   : null,
//             ),
//           ),
//           const SizedBox(width: 16),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Color(0xFF6200EE),
//               ),
//               child: const Text(
//                 'MAIN Gate: Guard',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context); // Close drawer when tapped
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xFF6200EE),
//             child: TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.white,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white,
//               tabs: const [
//                 Tab(text: "Visitor"),
//                 Tab(text: "Delivery"),
//                 Tab(text: "Taxi"),
//                 Tab(text: "Notice"),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: const [
//                 VisitorTab(),
//                 DeliveryTab(),
//                 TaxiTab(),
//                 NoticeTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   XFile? _userImage; // Declare _userImage as nullable to store the image

//   Future<void> captureUserImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       setState(() {
//         _userImage = pickedImage;
//       });
//     }
//   }

//   // void captureUserImage() async {
//   //   // Placeholder for image capture functionality
//   //   // You can use an image picker here to capture/select an image
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.deepPurple,
//                     backgroundImage: _userImage != null
//                         ? FileImage(File(_userImage!.path))
//                         : null,
//                     child: _userImage == null
//                         ? const Icon(Icons.camera_alt,
//                             size: 50, color: Colors.white)
//                         : null,
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: captureUserImage,
//                       child: const CircleAvatar(
//                         radius: 16,
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.camera, color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Name Field
//               TextFormField(
//                 style: const TextStyle(color: Colors.black, fontSize: 14),
//                 decoration: const InputDecoration(
//                   labelText: "Name",
//                   hintText: "Enter your name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Address Field
//               TextFormField(
//                 style: const TextStyle(color: Colors.black, fontSize: 14),
//                 decoration: const InputDecoration(
//                   labelText: "Address",
//                   hintText: "Enter your address",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Contact Number Field
//               TextFormField(
//                 style: const TextStyle(color: Colors.black, fontSize: 14),
//                 decoration: const InputDecoration(
//                   labelText: "Contact No",
//                   hintText: "Enter your contact number",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a contact number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Alternate Contact Number Field
//               TextFormField(
//                 style: const TextStyle(color: Colors.black, fontSize: 14),
//                 keyboardType: TextInputType.number,
//                 maxLength: 10,
//                 decoration: const InputDecoration(
//                   labelText: "Alternate Contact No",
//                   hintText: "Enter alternate contact number",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an alternate contact number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Save Button
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Save data logic here
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6200EE),
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// class DeliveryTab extends StatelessWidget {
//   const DeliveryTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const VisitorTab();
//   }
// }

// class TaxiTab extends StatelessWidget {
//   const TaxiTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const VisitorTab();
//   }
// }

// class NoticeTab extends StatelessWidget {
//   const NoticeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 25,
//       itemBuilder: (context, index) {
//         final bool isOdd = index.isOdd;
//         final Color tileColor =
//             isOdd ? Colors.deepPurple.shade200 : Colors.deepPurple.shade400;
//         final Color textColor = isOdd ? Colors.black : Colors.white;

//         return ListTile(
//           tileColor: tileColor,
//           title: Text(
//             "Notice ${index + 1}",
//             style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
//           ),
//           onTap: () {},
//         );
//       },
//     );
//   }
// }
