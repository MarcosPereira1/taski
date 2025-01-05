import 'package:flutter/material.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class WelcomeMessage extends StatelessWidget {
  final String userName;
  final int taskCount;

  const WelcomeMessage({super.key, required this.userName, required this.taskCount});

  @override
  Widget build(BuildContext context) {
    final bool hasTasks = taskCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Welcome, ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Pallette.gray600),
            children: [
              TextSpan(
                text: userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Pallette.blue500),
              ),
              TextSpan(text: '.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Pallette.gray600)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          hasTasks ? "You've got $taskCount tasks to do." : "Create tasks to achieve more.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Pallette.gray400),
        ),
      ],
    );
  }
}
