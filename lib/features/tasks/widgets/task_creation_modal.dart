import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/features/tasks/viewmodels/task_view_model.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class TaskCreationModal extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const TaskCreationModal({super.key, required this.titleController, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Pallette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.check_box_outline_blank, color: Pallette.gray400),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "What's in your mind?",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Pallette.gray400, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Pallette.gray600),
                ),
              ),
            ],
          ),
          Divider(color: Pallette.gray200, thickness: 1),
          Row(
            children: [
              Icon(Icons.edit, color: Pallette.gray400),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Add a note...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Pallette.gray400, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  maxLines: 1,
                  style: TextStyle(color: Pallette.gray600, fontSize: 14, fontWeight: FontWeight.w400),
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
                  Provider.of<TaskViewModel>(
                    context,
                    listen: false,
                  ).addTask(titleController.text, descriptionController.text);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Task created successfully!')));
                }
              },
              child: Text(
                'Create',
                style: TextStyle(color: Pallette.blue500, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
