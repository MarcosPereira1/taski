import 'package:flutter/material.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:taski/features/tasks/widgets/task_edit_modal.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final ValueChanged<Task>? onEdit;
  final bool showDescription;
  final bool showOptionsIcon;
  final bool showDeleteIcon;

  const TaskItem({
    super.key,
    required this.task,
    this.onToggle,
    this.onDelete,
    this.onEdit,
    this.showDescription = true,
    this.showOptionsIcon = true,
    this.showDeleteIcon = false, // Adicionado para exibir a lixeira no DoneTasksPage
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isDescriptionVisible = false;

  void _toggleDescriptionVisibility() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
  }

  void _openEditModal(BuildContext context) {
    if (widget.onEdit == null) {
      debugPrint("onEdit callback is null. Cannot open edit modal.");
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return TaskEditModal(
          task: widget.task,
          onEdit: widget.onEdit!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isCheckDisabled = widget.task.isCompleted && widget.onToggle == null;

    return GestureDetector(
      onTap: widget.showDescription ? _toggleDescriptionVisibility : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Pallette.gray50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: isCheckDisabled ? null : widget.onToggle,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isCheckDisabled
                            ? Pallette.gray200
                            : (widget.task.isCompleted
                                ? Pallette.blue500
                                : Pallette.gray400),
                        width: 1.5,
                      ),
                      color: isCheckDisabled
                          ? Pallette.gray200
                          : (widget.task.isCompleted
                              ? Pallette.blue500
                              : Colors.transparent),
                    ),
                    child: widget.task.isCompleted
                        ? Icon(
                            Icons.check,
                            color: isCheckDisabled
                                ? Pallette.gray400
                                : Pallette.white,
                            size: 14,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.task.isCompleted
                          ? Pallette.gray400
                          : Pallette.gray900,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                if (widget.showDeleteIcon)
                  IconButton(
                    icon: Icon(Icons.delete, color: Pallette.red500),
                    onPressed: widget.onDelete,
                  )
                else if (widget.showOptionsIcon)
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Pallette.gray400,
                    ),
                    onSelected: (String value) {
                      if (value == 'edit') {
                        _openEditModal(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                    ],
                  ),
              ],
            ),
            if (_isDescriptionVisible &&
                widget.showDescription &&
                widget.task.description != null)
              const SizedBox(height: 8),
            if (_isDescriptionVisible &&
                widget.showDescription &&
                widget.task.description != null)
              Text(
                widget.task.description!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Pallette.gray400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
