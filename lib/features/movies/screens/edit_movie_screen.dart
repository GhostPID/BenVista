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
  late TextEditingController notesController;
  late double score;
  late String status;
  DateTime? selectedDate;

  @override
    void initState() {
      super.initState();

      titleController =
          TextEditingController(text: widget.movie.title);

      notesController =
          TextEditingController(text: widget.movie.notes);

      score = widget.movie.score;
      status = widget.movie.status;

      if (widget.movie.watchDate != null &&
       widget.movie.watchDate!.isNotEmpty) {
       selectedDate = DateTime.parse(widget.movie.watchDate!);
     }
    }

  void save() {
    final updatedMovie = Movie(
    id: widget.movie.id,
    title: titleController.text,
    score: score,
    status: status,
    notes: notesController.text,
    watchDate: selectedDate?.toString().split(' ')[0],
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
              TextField(
                controller: notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  border: OutlineInputBorder(),
                ),
              ),
              
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

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: selectedDate ?? DateTime.now(),
                );

                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Text(
                selectedDate == null
                    ? "Select Watch Date"
                    : selectedDate.toString().split(' ')[0],
              ),
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
    @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }
}