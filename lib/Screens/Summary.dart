import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../provider_manager/state_management.dart';
import '../shared_prefe_manager/theme_prefs.dart';
import '../widgets/bottom_nev.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
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
        title: const Text('Summary', style: TextStyle(fontFamily: 'Text')),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => _toggleTheme(!isDark),
          ),
        ],
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Subjects: ${provider.subjects.length}',
                    style: const TextStyle(fontSize: 18)),
                Text('Average Mark: ${provider.averageMark.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18)),
                Text('Overall Grade: ${provider.overallGrade}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                const Text('Detailed Subjects:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.subjects.length,
                    itemBuilder: (context, index) {
                      final subject = provider.subjects[index];
                      return Card(
                        child: ListTile(
                          title: Text(subject.name),
                          subtitle: Text(
                            'Mark: ${subject.mark}, Grade: ${subject.grade}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),


      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
