import 'package:flutter/material.dart';
import 'package:taski/features/tasks/views/done_tasks_page.dart';
import 'package:taski/features/tasks/widgets/home_content.dart';
import 'package:taski/features/tasks/views/create_task_page.dart';
import 'package:taski/features/tasks/views/search_task_page.dart';
import 'package:taski/core/widgets/custom_app_bar.dart';
import 'package:taski/core/widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(onNavigateToCreateTask: _navigateToCreateTask),
      const CreateTaskPage(),
      const SearchTaskPage(),
      const DoneTasksPage(),
    ];
  }

  void _navigateToCreateTask() {
    _pageController.jumpToPage(1);
    setState(() {
      _currentIndex = 1;
    });
  }

  void _onNavBarTap(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: _currentIndex, onTap: _onNavBarTap),
    );
  }
}
