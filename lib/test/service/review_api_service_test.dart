import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:login_app/models/review_model.dart';
import 'package:login_app/services/review_api_service.dart';



void main() {
  group('ReviewApiService', () {
    test('getReviews retorna una lista de reseñas si la respuesta es 200',
        () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              'id': 1,
              'bookTitle': 'El Principito',
              'genre': 'Fantasía',
              'comment': 'Una historia tierna y reflexiva.',
              'rating': 5,
              'recommended': true,
            }
          ]),
          200,
        );
      });

      final service = ReviewApiService(
        baseUrl: 'https://api.fake.com',
        client: mockClient,
      );

      final reviews = await service.getReviews();

      expect(reviews.length, 1);
      expect(reviews.first.bookTitle, 'El Principito');
      expect(reviews.first.rating, 5);
      expect(reviews.first.recommended, true);
    });

    test('createReview envía una reseña y retorna la reseña creada', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/reviews');

        return http.Response(
          jsonEncode({
            'id': 2,
            'bookTitle': 'Harry Potter',
            'genre': 'Fantasía',
            'comment': 'Tiene magia y aventura.',
            'rating': 5,
            'recommended': true,
          }),
          201,
        );
      });

      final service = ReviewApiService(
        baseUrl: 'https://api.fake.com',
        client: mockClient,
      );

      final review = ReviewModel(
        bookTitle: 'Harry Potter',
        genre: 'Fantasía',
        comment: 'Tiene magia y aventura.',
        rating: 5,
        recommended: true,
      );

      final createdReview = await service.createReview(review);

      expect(createdReview.id, 2);
      expect(createdReview.bookTitle, 'Harry Potter');
    });

    test('getReviews lanza excepción si la respuesta no es 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Error', 500);
      });

      final service = ReviewApiService(
        baseUrl: 'https://api.fake.com',
        client: mockClient,
      );

      expect(
        () => service.getReviews(),
        throwsException,
      );
    });
  });
}