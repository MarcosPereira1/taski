import 'package:flutter/material.dart';
import 'package:taski/resources/app_icons.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class EmptyTaskView extends StatelessWidget {
  final VoidCallback onCreateTask;

  const EmptyTaskView({super.key, required this.onCreateTask});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset( AppIcons.emptyTasks, width: 150, height: 150),
        const SizedBox(height: 16),
        Text(
          'You have no task listed.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Pallette.gray400),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: onCreateTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallette.blue100,
            foregroundColor: Pallette.blue500,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppIcons.addIcon, width: 20, height: 20),
              const SizedBox(width: 12),
              const Text('Create task'),
            ],
          ),
        ),
      ],
    );
  }
}
