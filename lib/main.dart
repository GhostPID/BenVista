import 'package:flutter/material.dart';
import 'add_movie_screen.dart';
import 'database/movie_db.dart';
import 'models/movie.dart';

void main() {
  runApp(const MovieVaultApp());
}

class MovieVaultApp extends StatelessWidget {
  const MovieVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieVault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() async {
    final data = await MovieDB.instance.getMovies();

    setState(() {
      movies = data;
    });
  }

  void addMovie(Map<String, dynamic> movieData) async {
    final movie = Movie(
      title: movieData["title"],
      score: movieData["score"],
      status: movieData["status"],
    );

    await MovieDB.instance.createMovie(movie);
    loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Watch List"),
      ),
      body: movies.isEmpty
          ? const Center(child: Text("No movies yet. Tap + to add."))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(
                    "Score: ${movie.score} | Status: ${movie.status}",
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMovieScreen(),
            ),
          );

          if (result != null) {
            addMovie(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}