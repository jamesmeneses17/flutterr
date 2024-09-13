import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import 'task_storage.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  final storage = TaskStorage();
  final notifier = TaskListNotifier(storage);
  notifier.loadTasks(); // Cargar tareas al iniciar
  return notifier;
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  final TaskStorage _storage;

  TaskListNotifier(this._storage) : super([]);

  Future<void> loadTasks() async {
    state = await _storage.loadTasks();
  }

  Future<void> addTask(Task task) async {
    state = [...state, task];
    await _storage.saveTasks(state);
  }

  Future<void> toggleTask(int index) async {
    final task = state[index];
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    state = [
      ...state.sublist(0, index),
      updatedTask,
      ...state.sublist(index + 1),
    ];
    await _storage.saveTasks(state);
  }

  Future<void> deleteCompletedTasks() async {
    state = state.where((task) => !task.isCompleted).toList();
    await _storage.saveTasks(state);
  }
}
