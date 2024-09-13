import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'Listado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28, // Tamaño del texto
              fontWeight: FontWeight.bold, // Negrita
              letterSpacing: 1.5, // Espaciado entre letras
              shadows: [
                Shadow(
                  blurRadius: 10.0, // Sombra difusa para resaltar el texto
                  color: Colors.black45, // Color de la sombra
                  offset: Offset(2.0, 2.0), // Desplazamiento de la sombra
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent, // Fondo transparente
          elevation: 0, // Sin sombra debajo del AppBar
        ),
      ),
      body: taskList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_tasks.png',
                    width: 100, // Ajusta el tamaño según sea necesario
                    height: 100,
                  ),
                  SizedBox(height: 20), // Espacio entre la imagen y el texto
                  Text(
                    'No hay tareas agregadas',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                return ListTile(
                  title: Text(task.title),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      ref.read(taskListProvider.notifier).toggleTask(index);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: task,
                    );
                  },
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddTaskDialog(context, ref);
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16), // Espaciado entre los botones
          FloatingActionButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context, ref);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar nueva tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Nombre de la tarea'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    InputDecoration(labelText: 'Descripción de la tarea'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  ref
                      .read(taskListProvider.notifier)
                      .addTask(Task(title: title, description: description));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text(
              '¿Estás seguro de que quieres eliminar todas las tareas completadas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                ref.read(taskListProvider.notifier).deleteCompletedTasks();
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
