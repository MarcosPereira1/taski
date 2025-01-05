import 'package:flutter_test/flutter_test.dart';
import 'package:taski/features/tasks/models/task_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Task Model Tests', () {
    test('Should create a Task with default values', () {
      final task = Task(title: 'Learn Flutter');

      expect(task.title, 'Learn Flutter', reason: 'Title should match the given value.');
      expect(task.isCompleted, false, reason: 'isCompleted should be false by default.');
      expect(task.description, isNull, reason: 'Description should be null by default.');
      expect(task.id, isA<String>(), reason: 'ID should be a string.');
      expect(task.id.length, greaterThan(0), reason: 'ID should be generated if not provided.');
    });

    test('Should create a Task with a custom ID if provided', () {
      const customId = 'custom_id';
      final task = Task(
        id: customId,
        title: 'Learn Unit Testing',
        description: 'Write unit tests for Hive models.',
      );

      expect(task.id, customId, reason: 'When an ID is provided, the model should use it.');
      expect(task.title, 'Learn Unit Testing');
      expect(task.description, 'Write unit tests for Hive models.');
      expect(task.isCompleted, false);
    });

    test('Should copy a Task and only update specified fields', () {
      final originalTask = Task(
        title: 'Original Title',
        isCompleted: false,
        description: 'Original description',
      );

      final updatedTask = originalTask.copyWith(
        title: 'New Title',
        isCompleted: true,
      );

      expect(updatedTask.title, 'New Title');
      expect(updatedTask.isCompleted, true);

      expect(updatedTask.description, originalTask.description);
      expect(updatedTask.id, originalTask.id, reason: 'The ID should not change unless a new one is provided.');
    });

    test('Should keep the same ID when using copyWith without specifying a new ID', () {
      final originalTask = Task(title: 'Original Task');

      final copiedTask = originalTask.copyWith();

      expect(copiedTask.id, originalTask.id,
          reason: 'The ID should remain the same if not provided in copyWith.');
    });

    test('Should update the ID if a new one is provided in copyWith', () {
      final originalTask = Task(title: 'Task with a new ID');

      final newId = const Uuid().v4();
      final copiedTask = originalTask.copyWith(id: newId);

      expect(copiedTask.id, newId,
          reason: 'The ID should be updated if provided in copyWith.');
      expect(copiedTask.title, originalTask.title);
    });
  });
}
