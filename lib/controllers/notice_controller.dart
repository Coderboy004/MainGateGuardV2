import 'package:maingateguard/models/notice_models.dart';

class NoticeController {
  static final NoticeController _instance = NoticeController._internal();
  factory NoticeController() => _instance;
  NoticeController._internal();

  final List<Notice> _notices = [
    Notice(
      id: '1',
      title: 'Notice 1',
      description: 'This is the first notice.',
      date: DateTime.now(),
      filePath: 'assets/files/Ashish Resume.pdf',
    ),
    Notice(
      id: '2',
      title: 'Notice 2',
      description: 'This is the second notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '3',
      title: 'Notice 3',
      description: 'This is the third notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '4',
      title: 'Notice 4',
      description: 'This is the fourth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '5',
      title: 'Notice 5',
      description: 'This is the fifth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '6',
      title: 'Notice 6',
      description: 'This is the sixth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '7',
      title: 'Notice 7',
      description: 'This is the seventh notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '8',
      title: 'Notice 8',
      description: 'This is the eighth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '9',
      title: 'Notice 9',
      description: 'This is the ninth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '10',
      title: 'Notice 10',
      description: 'This is the tenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '11',
      title: 'Notice 11',
      description: 'This is the eleventh notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '12',
      title: 'Notice 12',
      description: 'This is the twelfth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '13',
      title: 'Notice 13',
      description: 'This is the thirteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '14',
      title: 'Notice 14',
      description: 'This is the fourteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '15',
      title: 'Notice 15',
      description: 'This is the fifteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '16',
      title: 'Notice 16',
      description: 'This is the sixteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '17',
      title: 'Notice 17',
      description: 'This is the seventeenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '18',
      title: 'Notice 18',
      description: 'This is the eighteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '19',
      title: 'Notice 19',
      description: 'This is the nineteenth notice.',
      date: DateTime.now(),
    ),
    Notice(
      id: '20',
      title: 'Notice 20',
      description: 'This is the twentieth notice.',
      date: DateTime.now(),
    ),
  ];
  List<Notice> getNotices() => _notices;

  void addNotice(Notice notice) {
    _notices.add(notice);
  }

  void deleteNotice(String id) {
    _notices.removeWhere((notice) => notice.id == id);
  }
}
