import 'package:flutter/foundation.dart' hide Summary;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Screens/Subject_list.dart';
import '../Screens/Add_subjects.dart';
import '../Screens/Summary.dart' hide subject_list;

class RouteManager {
  static final GoRouter router = GoRouter(
    initialLocation: '/subjects',
    routes: [
      GoRoute(
        path: '/subjects',
        builder: (context, state) => const subject_list(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const AddSubjects(),
      ),
      GoRoute(
        path: '/summary',
        builder: (context, state) => const Summary(),
      ),
    ],
  );
}

