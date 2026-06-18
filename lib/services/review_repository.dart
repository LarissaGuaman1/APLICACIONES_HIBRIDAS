import '../data/models/review_model.dart';
import 'local_database_service.dart';
import 'review_api_service.dart';
import 'sync_service.dart';

class ReviewRepository {
  final LocalDatabaseService localDb;
  final ReviewApiService apiService;
  late final SyncService syncService;

  ReviewRepository({
    required this.localDb,
    required this.apiService,
  }) {
    syncService = SyncService(
      localDb: localDb,
      apiService: apiService,
    );
  }

  Future<void> saveReview(ReviewModel review) async {
    await syncService.saveReviewOfflineFirst(review);
  }

  Future<List<ReviewModel>> getLocalReviews() async {
    return localDb.getAllReviews();
  }

  Future<void> syncReviews() async {
    await syncService.syncPendingReviews();
  }

  Future<void> deleteReview(ReviewModel review) async {
    if (review.remoteId != null) {
      try {
        await apiService.deleteReview(review.remoteId!);
      } catch (_) {
        // Si no se puede borrar en la API, igual se borra localmente.
      }
    }

    if (review.localId != null) {
      await localDb.deleteLocalReview(review.localId!);
    }
  }
}