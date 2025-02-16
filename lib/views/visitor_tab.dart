import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maingateguard/models/visitor_models.dart';

// Visitor Tab
class VisitorTab extends StatefulWidget {
  final Visitor? visitor;
  const VisitorTab({super.key, this.visitor});

  @override
  State<VisitorTab> createState() => _VisitorTabState();
}

class _VisitorTabState extends State<VisitorTab> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _visitorExists = false;
  XFile? _visitorImage;

  void checkVisitor() {
    setState(() {
      _visitorExists = _phoneController.text == "9876543210";
    });
  }

  Future<void> captureVisitorImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _visitorImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                labelText: "Search Flats",

                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                ), // Optional, you can adjust color
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ), // Optional, customize icon color
                filled: true, // Makes the background color fill
                fillColor: Colors.white, // Set the background color to white
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ), // Adjust padding for better UX
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Rounded corners with a radius of 20
                  borderSide: BorderSide.none, // Remove the border side color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ), // Focused border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade400,
                    width: 1,
                  ), // Normal border color
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            TextField(
              controller: _phoneController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: const TextStyle(color: Colors.deepPurple),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: checkVisitor,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // If visitor exists, show image and details
            if (_visitorExists) ...[
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage:
                        _visitorImage != null
                            ? FileImage(File(_visitorImage!.path))
                            : null,
                    child:
                        _visitorImage == null
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
                      onTap: captureVisitorImage,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text("John Doe"),
              const Text("Flat A-101"),
              const Text("Landmark"),
              const Text("Pincode"),
              const Text("State"),
              const Text("City"),
            ] else ...[
              // If visitor does not exist, show Name and Address fields
              Column(
                children: [
                  // Circular Image Avatar for capturing visitor image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage:
                            _visitorImage != null
                                ? FileImage(File(_visitorImage!.path))
                                : null,
                        child:
                            _visitorImage == null
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
                          onTap: captureVisitorImage,
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
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.people,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Address Field
                  TextField(
                    controller: _addressController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: const Icon(
                        Icons.house,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Landmark Field
                  TextField(
                    controller: _landmarkController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Landmark",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: const Icon(
                        Icons.home,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Pincode Field
                  TextField(
                    controller: _pincodeController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: "Pincode",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // State Field
                  TextField(
                    controller: _stateController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "State",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.house,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // City Field
                  TextField(
                    controller: _cityController,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "City",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      prefixIcon: const Icon(
                        Icons.house,
                        color: Colors.deepPurple,
                      ), // Optional, customize icon color

                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 1,
                        ), // Normal border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],

            const SizedBox(height: 16),

            // Request Check-in Button
            ElevatedButton(
              onPressed:
                  () => showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text("Check-in Request"),
                          content: const Text("Visitor check-in request sent."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6200EE),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              ),
              child: const Text(
                "Request Check-in",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
