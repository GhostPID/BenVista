import 'package:flutter/material.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  double score = 5;
  String status = "Watched";

  void saveMovie() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "title": titleController.text,
        "score": score,
        "status": status,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Movie Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Score
              Text("Score: ${score.toStringAsFixed(1)}"),
              Slider(
                value: score,
                min: 0,
                max: 10,
                divisions: 20,
                label: score.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    score = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // Status
              DropdownButtonFormField<String>(
                initialValue: status,
                items: const [
                  DropdownMenuItem(value: "Watched", child: Text("Watched")),
                  DropdownMenuItem(value: "Watching", child: Text("Watching")),
                  DropdownMenuItem(value: "Plan to Watch", child: Text("Plan to Watch")),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Status",
                ),
              ),

              const Spacer(),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveMovie,
                  child: const Text("Save Movie"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}