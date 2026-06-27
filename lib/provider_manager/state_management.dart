import 'package:flutter/material.dart';
import '../Model/subject_model.dart';


class SubjectProvider with ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  void addSubject(String name, int mark) {
    _subjects.add(Subject(name, mark));
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  List<Subject> get passingSubjects =>
      _subjects.where((s) => s.mark >= 50).toList();

  double get averageMark =>
      _subjects.isEmpty ? 0 : _subjects.map((s) => s.mark).reduce((a, b) => a + b) / _subjects.length;

  String get overallGrade {
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }
}
