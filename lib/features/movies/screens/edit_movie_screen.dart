import 'package:flutter/material.dart';
import '../../../models/movie.dart';

class EditMovieScreen extends StatefulWidget {
  final Movie movie;

  const EditMovieScreen({super.key, required this.movie});

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  late TextEditingController titleController;
  late double score;
  late String status;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.movie.title);
    score = widget.movie.score;
    status = widget.movie.status;
  }

  void save() {
    final updatedMovie = Movie(
      id: widget.movie.id,
      title: titleController.text,
      score: score,
      status: status,
    );

    Navigator.pop(context, updatedMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Movie")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 20),

            Text("Score: ${score.toStringAsFixed(1)}"),
            Slider(
              value: score,
              min: 0,
              max: 10,
              divisions: 20,
              onChanged: (v) {
                setState(() => score = v);
              },
            ),

            DropdownButton<String>(
              value: status,
              items: const [
                DropdownMenuItem(value: "Watched", child: Text("Watched")),
                DropdownMenuItem(value: "Watching", child: Text("Watching")),
                DropdownMenuItem(value: "Plan to Watch", child: Text("Plan to Watch")),
              ],
              onChanged: (v) {
                setState(() => status = v!);
              },
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: save,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}