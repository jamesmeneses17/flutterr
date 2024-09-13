import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener la tarea pasada como argumento
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la tarea'),
        backgroundColor: Color.fromARGB(255, 177, 212, 240), // Color azul personalizado
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              task.description,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              task.isCompleted ? 'Completada' : 'Pendiente',
              style: TextStyle(
                  fontSize: 20,
                  color: task.isCompleted ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
