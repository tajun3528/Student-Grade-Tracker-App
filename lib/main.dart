import 'package:flutter/material.dart';
import 'package:grade_calculator/provider_manager/state_management.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SubjectProvider(),
      child: const MyApp(),
    ),
  );
}

