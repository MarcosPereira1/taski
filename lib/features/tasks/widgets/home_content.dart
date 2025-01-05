import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/features/tasks/viewmodels/task_view_model.dart';
import 'package:taski/features/tasks/widgets/task_list_view.dart';
import 'package:taski/features/tasks/widgets/welcome_message.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class HomeContent extends StatelessWidget {
  final VoidCallback onNavigateToCreateTask;

  const HomeContent({super.key, required this.onNavigateToCreateTask});

  @override
  Widget build(BuildContext context) {
    final TaskViewModel taskViewModel = Provider.of<TaskViewModel>(context);
    final List<Task> tasks = taskViewModel.uncompletedTasks;

    return Container(
      color: Pallette.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WelcomeMessage(userName: 'John', taskCount: tasks.length),
            const SizedBox(height: 16),
            Expanded(
              child: TaskListView(
                tasks: tasks,
                onTaskToggle: (Task task) {
                  taskViewModel.toggleTaskCompletion(taskViewModel.tasks.indexOf(task));
                },
                onTaskEdit: (Task updatedTask) {
                  final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
                  taskViewModel.updateTask(updatedTask);
                },

                onEmptyCreateTask: onNavigateToCreateTask,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
