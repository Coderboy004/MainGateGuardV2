import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileOpener {
  // Function to open files
  static Future<void> openFile(String filePath, {BuildContext? context}) async {
    try {
      if (filePath.startsWith('assets/')) {
        // If the file is in assets, copy it to local storage and open
        final file = await _copyAssetToLocal(filePath);
        if (file != null) {
          await OpenFile.open(file.path);
        } else {
          throw 'Failed to load the file from assets.';
        }
      } else {
        // If the file is a local path, open it directly
        await OpenFile.open(filePath);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error opening file: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if (context != null) {
        Fluttertoast.showToast(
          msg: "Failed to open file: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  // Helper function to copy an asset file to local storage
  static Future<File?> _copyAssetToLocal(String assetPath) async {
    try {
      // Load the asset file
      final byteData = await rootBundle.load(assetPath);
      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      // Create a file in the temporary directory
      final filePath = '${directory.path}/${assetPath.split('/').last}';
      final file = File(filePath);
      // Write the asset data to the file
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return file;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error copying asset to local: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
