// ignore_for_file: unused_element
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maingateguard/controllers/parking_controller.dart';
import 'package:maingateguard/views/delivery_tab.dart';
import 'package:maingateguard/views/notice_tab.dart';
import 'package:maingateguard/views/parking_tab.dart';
import 'package:maingateguard/views/taxi_tab.dart';
import 'package:maingateguard/views/visitor_tab.dart';
import 'package:provider/provider.dart';

void main() {
  debugDisableShadows =
      true; // Optional: Disable shadows for performance testing
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ParkingController(),
        ), // 🔥 Ensure Provider is available globally
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Default to light mode
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6200EE)),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF), // Light mode text color
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      home: const MainGateGuardScreen(),
    );
  }
}

class MainGateGuardScreen extends StatefulWidget {
  const MainGateGuardScreen({super.key});

  @override
  State<MainGateGuardScreen> createState() => _MainGateGuardScreenState();
}

class _MainGateGuardScreenState extends State<MainGateGuardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  XFile? _profileImage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6200EE),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          // Profile Icon
          GestureDetector(
            onTap: _navigateToEditProfile,
            child: CircleAvatar(
              backgroundImage:
                  _profileImage != null
                      ? FileImage(File(_profileImage!.path))
                      : null,
              backgroundColor: Colors.white,
              child:
                  _profileImage == null
                      ? const Icon(Icons.person, color: Colors.deepPurple)
                      : null,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            _buildDrawerHeader(),
            ListTile(
              title: const Text('Pre-Requested Parking'),
              onTap: () {
                Navigator.pop(context); // Close drawer when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF6200EE),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: "Visitor"),
                Tab(text: "Delivery"),
                Tab(text: "Taxi"),
                Tab(text: "Notice"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const VisitorTab(),
                const DeliveryTab(),
                const TaxiTab(),
                NoticeTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomLeft,
      color: const Color(0xFF6200EE),
      height: 150,
      width: double.infinity,
      child: const Text(
        "MAIN Gate: Guard",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _userImage; // Declare _userImage as nullable to store the image

  Future<void> captureUserImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _userImage = pickedImage;
      });
    }
  }

  // void captureUserImage() async {
  //   // Placeholder for image capture functionality
  //   // You can use an image picker here to capture/select an image
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage:
                        _userImage != null
                            ? FileImage(File(_userImage!.path))
                            : null,
                    child:
                        _userImage == null
                            ? const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: captureUserImage,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Name Field
              TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address Field
              TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Contact Number Field
              TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                decoration: const InputDecoration(
                  labelText: "Contact No",
                  hintText: "Enter your contact number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Alternate Contact Number Field
              TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Alternate Contact No",
                  hintText: "Enter alternate contact number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an alternate contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save data logic here
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6200EE),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Need to add request for parking if owner tenant sends then it will come to direct security and security will alot the vehicle parking, 
// owner can pre book the parking for visitors

// add about tab - 

// add a chatting feature with user owner tenant 
// security can have access to the owners and their number
