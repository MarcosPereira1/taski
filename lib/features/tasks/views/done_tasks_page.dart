import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/features/tasks/viewmodels/task_view_model.dart';
import 'package:taski/features/tasks/widgets/task_item.dart';
import 'package:taski/resources/app_icons.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class DoneTasksPage extends StatelessWidget {
  const DoneTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskViewModel taskViewModel = Provider.of<TaskViewModel>(context);
    final List<Task> completedTasks = taskViewModel.completedTasks;

    return Scaffold(
      backgroundColor: Pallette.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completed Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (completedTasks.isNotEmpty)
                  TextButton(
                    onPressed: taskViewModel.deleteAllCompletedTasks,
                    child: Text('Delete all', style: TextStyle(color: Pallette.red500)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  completedTasks.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task task = completedTasks[index];
                          return TaskItem(
                            task: task,
                            onToggle: null,
                            onDelete: () {
                              taskViewModel.deleteTask(task);
                            },
                            showDescription: false,
                            showDeleteIcon: true,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppIcons.emptyTasks, width: 150, height: 150),
        const SizedBox(height: 16),
        Text("No completed tasks.", style: TextStyle(fontSize: 16, color: Pallette.gray400)),
      ],
    );
  }
}
