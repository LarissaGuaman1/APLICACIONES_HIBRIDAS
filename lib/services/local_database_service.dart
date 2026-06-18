import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/models/review_model.dart';

class LocalDatabaseService {
  static final LocalDatabaseService instance = LocalDatabaseService._init();

  static Database? _database;

  LocalDatabaseService._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('biblioteca_kawaii_v2.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reviews (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,
        remoteId TEXT,
        bookTitle TEXT NOT NULL,
        genre TEXT NOT NULL,
        comment TEXT NOT NULL,
        rating INTEGER NOT NULL,
        recommended INTEGER NOT NULL,
        isSynced INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertReview(ReviewModel review) async {
    final db = await instance.database;

    return db.insert(
      'reviews',
      review.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ReviewModel>> getAllReviews() async {
    final db = await instance.database;

    final result = await db.query(
      'reviews',
      orderBy: 'localId DESC',
    );

    return result.map((map) => ReviewModel.fromMap(map)).toList();
  }

  Future<List<ReviewModel>> getPendingReviews() async {
    final db = await instance.database;

    final result = await db.query(
      'reviews',
      where: 'isSynced = ?',
      whereArgs: [0],
      orderBy: 'localId ASC',
    );

    return result.map((map) => ReviewModel.fromMap(map)).toList();
  }

  Future<void> markAsSynced({
    required int localId,
    required String remoteId,
  }) async {
    final db = await instance.database;

    await db.update(
      'reviews',
      {
        'isSynced': 1,
        'remoteId': remoteId,
      },
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }

  Future<void> deleteLocalReview(int localId) async {
    final db = await instance.database;

    await db.delete(
      'reviews',
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }

  Future<void> deleteAllReviews() async {
    final db = await instance.database;
    await db.delete('reviews');
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}