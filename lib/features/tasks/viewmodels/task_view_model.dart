import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taski/features/tasks/models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  List<Task> get tasks => _taskBox.values.toList();

  List<Task> get completedTasks => tasks.where((task) => task.isCompleted).toList();

  List<Task> get uncompletedTasks => tasks.where((task) => !task.isCompleted).toList();

  void addTask(String title, String? description) {
    if (title.isEmpty) {
      throw ArgumentError('Title cannot be empty.');
    }

    final Task task = Task(title: title, description: description);

    _taskBox.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < _taskBox.length) {
      final task = _taskBox.getAt(index);
      if (task != null) {
        task.isCompleted = !task.isCompleted;
        task.save();
        notifyListeners();
      }
    }
  }

  void removeTask(int index) {
    if (index >= 0 && index < _taskBox.length) {
      _taskBox.deleteAt(index);
      notifyListeners();
    }
  }

  void deleteTask(Task task) {
    task.delete();
    notifyListeners();
  }

  void deleteAllCompletedTasks() {
    for (var task in completedTasks) {
      task.delete();
    }
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final key = _taskBox.keys.firstWhere((k) => (_taskBox.get(k)?.id == updatedTask.id), orElse: () => null);

    if (key != null) {
      final Task? existingTask = _taskBox.get(key);

      if (existingTask != null) {
        existingTask
          ..title = updatedTask.title
          ..description = updatedTask.description
          ..isCompleted = updatedTask.isCompleted;

        existingTask.save();
        notifyListeners();
      }
    }
  }
}
