import 'package:flutter/material.dart';
import 'package:taski/core/widgets/empty_task_view.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/features/tasks/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskToggle;
  final ValueChanged<Task> onTaskEdit;
  final VoidCallback onEmptyCreateTask;

  const TaskListView({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onTaskEdit,
    required this.onEmptyCreateTask,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyTaskView(onCreateTask: onEmptyCreateTask);
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final Task task = tasks[index];
        return TaskItem(
          task: task,
          onToggle: () => onTaskToggle(task),
          onEdit: (updatedTask) => onTaskEdit(updatedTask), 
        );
      },
    );
  }
}
