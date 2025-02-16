import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maingateguard/models/notice_models.dart';
import '../controllers/notice_controller.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddNoticeScreenState createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _filePath;
  final NoticeController _noticeController = NoticeController();

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _filePath = pickedFile.path;
      });
    }
  }

  void _submitNotice() {
    if (_formKey.currentState!.validate()) {
      final notice = Notice(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
        filePath: _filePath,
      );

      setState(() {
        _noticeController.addNotice(notice);
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Notice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator:
                    (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              if (_filePath != null)
                Text('Selected file: ${_filePath!.split('/').last}'),
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text('Attach File'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitNotice,
                child: const Text('Submit Notice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
