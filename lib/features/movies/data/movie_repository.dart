import '../../../models/movie.dart';
import '../../../core/database/movie_db.dart';

class MovieRepository {
  final db = MovieDB.instance;

  Future<List<Movie>> getAllMovies() async {
    return await db.getMovies();
  }

  Future<void> addMovie(Movie movie) async {
    await db.createMovie(movie);
  }

  Future<List<Movie>> searchMovies(String query) async {
    return await db.searchMovies(query);
  }

  Future<void> deleteMovie(int id) async {
    await db.deleteMovie(id);
  }

  Future<void> updateMovie(Movie movie) async {
    await db.updateMovie(movie);
  }
}