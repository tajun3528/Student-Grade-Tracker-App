import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../provider_manager/state_management.dart';
import '../shared_prefe_manager/theme_prefs.dart';

import '../widgets/bottom_nev.dart';

class subject_list extends StatefulWidget {
  const subject_list({super.key});

  @override
  State<subject_list> createState() => _subject_listState();
}

class _subject_listState extends State<subject_list> {
  final ThemePrefs _prefs = ThemePrefs();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool isDark = await _prefs.getTheme();
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void _toggleTheme(bool isDark) {
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _prefs.saveTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject list', style: TextStyle(fontFamily: 'Text')),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => _toggleTheme(!isDark),
          ),
        ],
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.subjects.length,
            itemBuilder: (context, index) {
              final subject = provider.subjects[index];
              return Dismissible(
                key: Key(subject.name),
                onDismissed: (_) => provider.removeSubject(index),
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
                child: ListTile(
                  title: Text(subject.name),
                  subtitle: Text('Mark: ${subject.mark}, Grade: ${subject.grade}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      provider.removeSubject(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${subject.name} deleted')),
                      );
                    },
                  ),
                ),
              );

            },
          );
        },
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
