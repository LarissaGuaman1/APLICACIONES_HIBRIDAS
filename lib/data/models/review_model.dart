class ReviewModel {
  final int? localId;
  final String? remoteId;
  final String bookTitle;
  final String genre;
  final String comment;
  final int rating;
  final bool recommended;

  // 0 = pendiente de subir
  // 1 = sincronizada con la API
  final int isSynced;

  ReviewModel({
    this.localId,
    this.remoteId,
    required this.bookTitle,
    required this.genre,
    required this.comment,
    required this.rating,
    required this.recommended,
    this.isSynced = 0,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      remoteId: json['id']?.toString(),
      bookTitle: json['bookTitle'] ?? '',
      genre: json['genre'] ?? '',
      comment: json['comment'] ?? '',
      rating: int.tryParse(json['rating'].toString()) ?? 0,
      recommended: json['recommended'] == true ||
          json['recommended'].toString().toLowerCase() == 'true',
      isSynced: 1,
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

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      localId: map['localId'],
      remoteId: map['remoteId'],
      bookTitle: map['bookTitle'],
      genre: map['genre'],
      comment: map['comment'],
      rating: map['rating'],
      recommended: map['recommended'] == 1,
      isSynced: map['isSynced'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'remoteId': remoteId,
      'bookTitle': bookTitle,
      'genre': genre,
      'comment': comment,
      'rating': rating,
      'recommended': recommended ? 1 : 0,
      'isSynced': isSynced,
    };
  }

  ReviewModel copyWith({
    int? localId,
    String? remoteId,
    String? bookTitle,
    String? genre,
    String? comment,
    int? rating,
    bool? recommended,
    int? isSynced,
  }) {
    return ReviewModel(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      bookTitle: bookTitle ?? this.bookTitle,
      genre: genre ?? this.genre,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      recommended: recommended ?? this.recommended,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}