import 'package:flutter/material.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:provider/provider.dart';


class CourseModelList extends StatelessWidget {
  const CourseModelList({super.key});

  @override
  Widget build(BuildContext context) {
    final course = context.watch<CourseModel>().course;
    final theme = Theme.of(context);
    final modules = List.generate(
      course!.modules!.length,
      (int index) => ExpansionTile(
        title: Text(course.modules[index].title),
        children: [
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              course.modules[index].description, 
              style: theme.textTheme.displaySmall,
            ),
          ),
        ],
      )
    );


    return Column(
      children: modules.map((module) {
        return module;
      }).toList(),
    );
  }
}