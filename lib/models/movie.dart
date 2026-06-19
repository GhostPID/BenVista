class Movie {
  final int? id;
  final String title;
  final double score;
  final String status;

  Movie({
    this.id,
    required this.title,
    required this.score,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'score': score,
      'status': status,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      score: (map['score'] as num).toDouble(),
      status: map['status'],
    );
  }
}