import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/movie.dart';

class MovieDB {
  static final MovieDB instance = MovieDB._init();
  static Database? _db;

  MovieDB._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('BenVista.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
     onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE movies ADD COLUMN notes TEXT DEFAULT ""',
          );
        }

        if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE movies ADD COLUMN watchDate TEXT',
          );
        }
      },
    );
  }

  Future<List<Movie>> searchMovies(String query) async {
  final db = await instance.database;

  final result = await db.query(
    'movies',
    where: 'title LIKE ?',
    whereArgs: ['%$query%'],
  );

  return result.map((e) => Movie.fromMap(e)).toList();
}

  Future<int> deleteMovie(int id) async {
  final db = await instance.database;
  return await db.delete(
    'movies',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        score REAL NOT NULL,
        status TEXT NOT NULL,
        notes TEXT,
        watchDate TEXT
      )
    ''');
  }

  Future<int> createMovie(Movie movie) async {
    final db = await instance.database;

    return await db.insert(
      'movies',
      {
        'title': movie.title,
        'score': movie.score,
        'status': movie.status,
        'notes': movie.notes,
        'watchDate': movie.watchDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<int> updateMovie(Movie movie) async {
  final db = await instance.database;

  return await db.update(
    'movies',
    movie.toMap(),
    where: 'id = ?',
    whereArgs: [movie.id],
  );
}

  Future<List<Movie>> getMovies() async {
    final db = await instance.database;

    final result = await db.query('movies');

    return result.map((e) => Movie.fromMap(e)).toList();
  }
}