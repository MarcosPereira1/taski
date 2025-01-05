import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/features/tasks/viewmodels/task_view_model.dart';
import 'package:taski/features/tasks/widgets/task_item.dart';
import 'package:taski/resources/app_icons.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class SearchTaskPage extends StatefulWidget {
  const SearchTaskPage({super.key});

  @override
  State<SearchTaskPage> createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    final tasks =
        taskViewModel.tasks
            .where((task) => !task.isCompleted && task.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Pallette.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 24.0),
            Expanded(
              child:
                  tasks.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskItem(
                            task: task,
                            onToggle: () {
                              taskViewModel.toggleTaskCompletion(index);
                            },
                            onEdit: (updatedTask) {
                              taskViewModel.updateTask(updatedTask);
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Material(
      elevation: 2,
      shadowColor: Pallette.gray200,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        cursorColor: Pallette.blue500,
        decoration: InputDecoration(
          hintText: 'Search tasks...',
          hintStyle: TextStyle(color: Pallette.gray400),
          prefixIcon: Icon(Icons.search, color: Pallette.blue500),
          suffixIcon:
              _searchQuery.isNotEmpty
                  ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(color: Pallette.gray200, shape: BoxShape.circle),
                      child: Icon(Icons.clear, color: Pallette.white, size: 16),
                    ),
                  )
                  : null,
          filled: true,
          fillColor: Pallette.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Pallette.blue500, width: 1.5),
          ),
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
        Text("No result found.", style: TextStyle(fontSize: 16, color: Pallette.gray400)),
      ],
    );
  }
}
