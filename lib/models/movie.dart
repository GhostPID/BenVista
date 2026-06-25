class Movie {
  final int? id;
  final String title;
  final double score;
  final String status;
  final String notes;
  final String? watchDate;

  Movie({
    this.id,
    required this.title,
    required this.score,
    required this.status,
    this.watchDate,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'score': score,
      'status': status,
      'notes': notes,
      'watchDate': watchDate,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      score: (map['score'] as num).toDouble(),
      status: map['status'],
      notes: map['notes'] ?? '',
      watchDate: map['watchDate'],
    );
  }
}