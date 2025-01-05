import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/features/tasks/viewmodels/task_view_model.dart';
import 'package:taski/features/tasks/widgets/task_item.dart';
import 'package:taski/features/tasks/widgets/welcome_message.dart';
import 'package:taski/features/tasks/widgets/task_creation_modal.dart';
import 'package:taski/resources/app_icons.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskViewModel taskViewModel = Provider.of<TaskViewModel>(context);
    final List<Task> tasks = taskViewModel.uncompletedTasks;

    return Scaffold(
      backgroundColor: Pallette.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WelcomeMessage(userName: 'John', taskCount: tasks.length),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      tasks.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AppIcons.emptyTasks, width: 150, height: 150),
                                const SizedBox(height: 16),
                                Text(
                                  'You have no task listed.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Pallette.gray400),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task task = tasks[index];
                              return TaskItem(
                                task: task,
                                onToggle: () {
                                  taskViewModel.toggleTaskCompletion(taskViewModel.tasks.indexOf(task));
                                },
                                onEdit: (Task updatedTask) {
                                  taskViewModel.updateTask(updatedTask);
                                },
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () => _showCreateTaskModal(context),
              backgroundColor: Pallette.blue500,
              child: Icon(Icons.add, color: Pallette.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTaskModal(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return TaskCreationModal(titleController: titleController, descriptionController: descriptionController);
      },
    );
  }
}
