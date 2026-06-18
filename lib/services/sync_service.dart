import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/models/review_model.dart';
import 'local_database_service.dart';
import 'review_api_service.dart';

class SyncService {
  final LocalDatabaseService localDb;
  final ReviewApiService apiService;

  SyncService({
    required this.localDb,
    required this.apiService,
  });

  Future<bool> hasConnection() async {
    final results = await Connectivity().checkConnectivity();

    if (results.contains(ConnectivityResult.none)) {
      return false;
    }

    return true;
  }

  Future<void> saveReviewOfflineFirst(ReviewModel review) async {
    final connected = await hasConnection();

    if (connected) {
      try {
        final createdReview = await apiService.createReview(review);

        final syncedReview = review.copyWith(
          remoteId: createdReview.remoteId,
          isSynced: 1,
        );

        await localDb.insertReview(syncedReview);
      } catch (_) {
        final pendingReview = review.copyWith(isSynced: 0);
        await localDb.insertReview(pendingReview);
      }
    } else {
      final pendingReview = review.copyWith(isSynced: 0);
      await localDb.insertReview(pendingReview);
    }
  }

  Future<void> syncPendingReviews() async {
    final connected = await hasConnection();

    if (!connected) {
      return;
    }

    final pendingReviews = await localDb.getPendingReviews();

    for (final review in pendingReviews) {
      try {
        final createdReview = await apiService.createReview(review);

        if (review.localId != null && createdReview.remoteId != null) {
          await localDb.markAsSynced(
            localId: review.localId!,
            remoteId: createdReview.remoteId!,
          );
        }
      } catch (_) {
        // Si falla, la reseña queda pendiente para intentar luego.
      }
    }
  }
}