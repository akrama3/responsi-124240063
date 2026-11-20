class Book {
  final int index;
  final String title;
  final String originalTitle;
  final String releaseDate;
  final String description;
  final int pages;
  final String cover;
  final int number;

  Book({
    required this.index,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.description,
    required this.pages,
    required this.cover,
    required this.number,
  });

  // factory constructor untuk membuat Book dari JSON
  factory Book.fromJson(Map<String, dynamic> jsonData) {
    return Book(
      index: jsonData['index'] ?? 0,
      title: jsonData['title'] ?? '',
      originalTitle: jsonData['originalTitle'] ?? '',
      releaseDate: jsonData['releaseDate'] ?? '',
      description: jsonData['description'] ?? '',
      pages: jsonData['pages'] ?? 0,
      cover: jsonData['cover'] ?? '',
      number: jsonData['number'] ?? 0,
    );
  }
}
