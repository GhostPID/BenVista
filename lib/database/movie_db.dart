import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class MovieDB {
  static final MovieDB instance = MovieDB._init();
  static Database? _db;

  MovieDB._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('movie_vault.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        score REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  Future<int> createMovie(Movie movie) async {
    final db = await instance.database;
    return await db.insert('movies', movie.toMap());
  }

  Future<List<Movie>> getMovies() async {
    final db = await instance.database;

    final result = await db.query('movies');

    return result.map((e) => Movie.fromMap(e)).toList();
  }
}