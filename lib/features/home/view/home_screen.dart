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
    return Scaffold(
      appBar: AppBar(
        elevation: 0, 
        titleTextStyle: const TextStyle(

        ),
        title: const Text('OQY'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      ),
      body: ListCourses.create(),
    );
  }
}