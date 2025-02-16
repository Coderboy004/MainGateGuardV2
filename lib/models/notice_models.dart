class Notice {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String? filePath; // Optional file (e.g., PDF, image)

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.filePath,
  });
}
