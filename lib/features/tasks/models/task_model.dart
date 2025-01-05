import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String? description;

  Task({
    String? id,
    required this.title,
    this.isCompleted = false,
    this.description,
  }) : id = id ?? const Uuid().v4();

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? description,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
    );
  }
}
