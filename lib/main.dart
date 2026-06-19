import 'package:flutter/material.dart';
import 'add_movie_screen.dart';
import 'core/database/movie_db.dart';
import 'models/movie.dart';
import 'features/movies/data/movie_repository.dart';
import 'features/movies/screens/edit_movie_screen.dart';

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
  final repo = MovieRepository();
  final TextEditingController searchController = TextEditingController();
 List<Movie> allMovies = [];
List<Movie> movies = [];
  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final data = await repo.getAllMovies();
    final query = searchController.text;

    if (query.isEmpty) {
      setState(() {
        allMovies = data;
        movies = data;
      });
    } else {
      final result = await repo.searchMovies(query);
      setState(() {
        allMovies = data;
        movies = result;
      });
    }
  }

 void addMovie(Map<String, dynamic> movieData) async {
  try {
    final movie = Movie(
      title: movieData["title"],
      score: movieData["score"],
      status: movieData["status"],
    );
    print("ADDING MOVIE: ${movieData.toString()}");

    await repo.addMovie(movie);
    print("MOVIE SAVED SUCCESSFULLY");
    await loadMovies();
  } catch (e) {
    print("ERROR ADDING MOVIE: $e");
  }
 }

void searchMovies(String query) async {
  if (query.isEmpty) {
    setState(() {
      movies = allMovies;
    });
    return;
  }

  final result = await repo.searchMovies(query);

  setState(() {
    movies = result;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text("My Watch List"),
  ),

  body: Column(
    children: [

      Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: searchController,
          onChanged: searchMovies,
          decoration: const InputDecoration(
            labelText: "Search movies...",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Color(0xFFF5F5F5),
          ),
        ),
      ),

      Expanded(
        child: movies.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_creation_outlined, size: 80),
                    SizedBox(height: 10),
                    Text(
                      "No movies yet",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("Tap + to add your first movie"),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Dismissible(
                    key: ValueKey(movie.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) async {
                      await repo.deleteMovie(movie.id!);
                      await loadMovies();
                    },
                    child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),

                      leading: CircleAvatar(
                        child: Text(movie.score.toString()),
                      ),

                      title: Text(
                        movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(
                        "Status: ${movie.status}",
                      ),

                      trailing: Icon(
                        movie.status == "Watched"
                            ? Icons.check_circle
                            : movie.status == "Watching"
                                ? Icons.play_circle
                                : Icons.schedule,
                        color: movie.status == "Watched"
                            ? Colors.green
                            : movie.status == "Watching"
                                ? Colors.orange
                                : Colors.grey,
                      ),
                    ),
                  ),
                  );
                },
              ),
      ),
    ],
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