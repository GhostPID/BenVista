class Movie {
  int? id;
  String title;
  double score;
  String status;

  Movie({
    this.id,
    required this.title,
    required this.score,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'score': score,
      'status': status,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      score: map['score'],
      status: map['status'],
    );
  }
}