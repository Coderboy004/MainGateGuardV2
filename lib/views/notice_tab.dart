import 'package:flutter/material.dart';
import 'package:maingateguard/constants/app_colors.dart';
import 'package:maingateguard/helper/files_helper.dart';
import '../controllers/notice_controller.dart';

class NoticeTab extends StatefulWidget {
  const NoticeTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoticeTabState createState() => _NoticeTabState();
}

class _NoticeTabState extends State<NoticeTab> {
  final NoticeController _noticeController = NoticeController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _noticeController.getNotices().length,
      itemBuilder: (context, index) {
        final notice = _noticeController.getNotices()[index];
        return ListTile(
          tileColor:
              index.isOdd
                  ? const Color.fromARGB(255, 245, 245, 245)
                  : const Color.fromARGB(255, 220, 208, 240),
          title: Text(
            notice.title,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notice.description,
                style: const TextStyle(color: Colors.deepPurple),
              ),
              if (notice.filePath != null)
                Text(
                  'Attachment: ${notice.filePath!.split('/').last}',
                  style: const TextStyle(color: Colors.deepPurple),
                ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.deepPurple),
            onPressed: () => _showDeleteDialog(context, notice.id),
          ),
          onTap: () {
            if (notice.filePath != null) {
              _showViewDialog(context, notice);
            }
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String noticeId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Notice'),
            content: const Text(
              'Are you sure you want to delete this notice?',
              style: TextStyle(color: AppColors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _noticeController.deleteNotice(noticeId);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _showViewDialog(BuildContext context, notice) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('View File'),
            content: const Text(
              'Are you sure you want to View this notice file?',
              style: TextStyle(color: AppColors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await FileOpener.openFile(notice.filePath);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // setState(() {
                  //   _noticeController.deleteNotice(noticeId);
                  // });
                  // Navigator.pop(context);
                },
                child: const Text(
                  'Open File',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
