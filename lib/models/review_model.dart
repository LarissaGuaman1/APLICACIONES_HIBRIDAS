class ReviewModel {
  final int? id;
  final String bookTitle;
  final String genre;
  final String comment;
  final int rating;
  final bool recommended;

  ReviewModel({
    this.id,
    required this.bookTitle,
    required this.genre,
    required this.comment,
    required this.rating,
    required this.recommended,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      bookTitle: json['bookTitle'],
      genre: json['genre'],
      comment: json['comment'],
      rating: json['rating'],
      recommended: json['recommended'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookTitle': bookTitle,
      'genre': genre,
      'comment': comment,
      'rating': rating,
      'recommended': recommended,
    };
  }
}