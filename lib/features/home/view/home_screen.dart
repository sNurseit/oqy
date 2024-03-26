import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/features/home/widgets/list_courses.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 0, 
        title: const Text('OQY'),
        titleTextStyle: theme.textTheme.titleMedium,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
        toolbarHeight: 60,
      ),
      body: ListCourses.create(),
    );
  }
}