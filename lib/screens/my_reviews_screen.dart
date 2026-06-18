import 'package:flutter/material.dart';

import '../main.dart';
import '../data/models/review_model.dart';
import '../services/api_config.dart';
import '../services/local_database_service.dart';
import '../services/review_api_service.dart';
import '../services/review_repository.dart';
import 'home_screen.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  late Future<List<ReviewModel>> reviewsFuture;

  final ReviewRepository repository = ReviewRepository(
    localDb: LocalDatabaseService.instance,
    apiService: ReviewApiService(
      baseUrl: ApiConfig.baseUrl,
    ),
  );

  @override
  void initState() {
    super.initState();
    reviewsFuture = repository.getLocalReviews();
    syncAndLoadReviews();
  }

  Future<void> syncAndLoadReviews() async {
    await repository.syncReviews();

    setState(() {
      reviewsFuture = repository.getLocalReviews();
    });
  }

  Widget reviewCard(ReviewModel review) {
    final bool synced = review.isSynced == 1;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: synced ? AppColors.crema : AppColors.rosa,
          child: Icon(
            synced ? Icons.cloud_done_rounded : Icons.cloud_upload_rounded,
            color: AppColors.texto,
          ),
        ),
        title: Text(
          review.bookTitle,
          style: const TextStyle(
            color: AppColors.texto,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          '${review.comment}\n'
          'Género: ${review.genre} | ⭐ ${review.rating}\n'
          '${synced ? "Sincronizada" : "Pendiente de subir"}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_rounded,
            color: Colors.pinkAccent,
          ),
          onPressed: () async {
            await repository.deleteReview(review);
            await syncAndLoadReviews();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeScreen().menuDrawer(context),
      appBar: AppBar(
        title: const Text('Mis reseñas'),
        actions: [
          IconButton(
            onPressed: syncAndLoadReviews,
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<ReviewModel>>(
        future: reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final reviews = snapshot.data ?? [];

          if (reviews.isEmpty) {
            return const Center(
              child: Text(
                'Aún no tienes reseñas guardadas.',
                style: TextStyle(
                  color: AppColors.texto,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: syncAndLoadReviews,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return reviewCard(reviews[index]);
              },
            ),
          );
        },
      ),
    );
  }
}