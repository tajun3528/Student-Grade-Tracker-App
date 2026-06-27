import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app.dart';
import '../provider_manager/state_management.dart';
import '../shared_prefe_manager/theme_prefs.dart';
import '../widgets/bottom_nev.dart';


class AddSubjects extends StatefulWidget {
  const AddSubjects({super.key});

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {
  final ThemePrefs _prefs = ThemePrefs();


  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

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
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subject', style: TextStyle(fontFamily: 'Text')),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => _toggleTheme(!isDark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Name required' : null,
              ),
              TextFormField(
                controller: _markController,
                decoration: const InputDecoration(labelText: 'Mark'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final mark = int.tryParse(value ?? '');
                  if (mark == null || mark < 0 || mark > 100) {
                    return 'Enter mark 0–100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final mark = int.parse(_markController.text);
                    context.read<SubjectProvider>().addSubject(name, mark);
                    context.go('/subjects');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
