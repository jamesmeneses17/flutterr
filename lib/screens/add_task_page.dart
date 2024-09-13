import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class AddTaskPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nueva Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Nombre de la tarea'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción de la tarea'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  final newTask = Task(title: title, description: description);
                  ref.read(taskListProvider.notifier).addTask(newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
