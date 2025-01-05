import 'package:flutter/material.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class TaskEditModal extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onEdit;

  const TaskEditModal({
    super.key,
    required this.task,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: task.title);
    final TextEditingController descriptionController =
        TextEditingController(text: task.description);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Pallette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Edit Task',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(Icons.title, color: Pallette.gray400),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Edit title",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Pallette.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Pallette.gray600,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Pallette.gray200, thickness: 1),
          Row(
            children: [
              Icon(Icons.notes, color: Pallette.gray400),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Edit description",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Pallette.gray400,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  maxLines: 1,
                  style: TextStyle(
                    color: Pallette.gray600,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (titleController.text.isNotEmpty) {
                  onEdit(
                    task.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task updated successfully!')),
                  );
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Pallette.blue500,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
