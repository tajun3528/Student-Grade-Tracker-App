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
}
