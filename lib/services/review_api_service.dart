import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/models/review_model.dart';

class ReviewApiService {
  final String baseUrl;
  final http.Client client;

  ReviewApiService({
    required this.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<List<ReviewModel>> getReviews() async {
    final url = Uri.parse('$baseUrl/reviews');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) {
        return ReviewModel.fromJson(item);
      }).toList();
    } else {
      throw Exception('Error al obtener reseñas desde la API');
    }
  }

  Future<ReviewModel> createReview(ReviewModel review) async {
    final url = Uri.parse('$baseUrl/reviews');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ReviewModel.fromJson(data);
    } else {
      throw Exception('Error al crear reseña en la API');
    }
  }

  Future<void> deleteReview(String remoteId) async {
    final url = Uri.parse('$baseUrl/reviews/$remoteId');

    final response = await client.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar reseña en la API');
    }
  }
}