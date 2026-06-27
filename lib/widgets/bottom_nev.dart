import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/subjects');
        break;
      case 1:
        context.go('/add');
        break;
      case 2:
        context.go('/summary');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_outlined),
          label: 'All Subjects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_comment_rounded),
          label: 'Add Subject',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize),
          label: 'Summary',
        ),
      ],
    );
  }
}
