import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/features/training/model/training_model.dart';
import 'package:provider/provider.dart';

class MyCreatedListWidget extends StatelessWidget {
  const MyCreatedListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TrainingModel>();
    return ListView(
      children: [
        if(model.active.isNotEmpty)
        _buildCourseList(
          context,
          'Active Courses',
          model.active,
        ),
        if(model.not_checked.isNotEmpty)
          _buildCourseList(
            context,
            'Not Checked Courses',
            model.not_checked,
          ),
        if(model.re_check.isNotEmpty)
        _buildCourseList(
          context,
          'Re-Check Courses',
          model.re_check,
        ),
        if(model.rejected.isNotEmpty)
          _buildCourseList(
            context,
            'Rejected Courses',
            model.rejected,
          ),
      ],
    );
  }

  Widget _buildCourseList(
    BuildContext context,
    String title,
    List<Course> courses,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18, fontWeight:FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: courses.map((course) => _buildCourseItem(context, course)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseItem(BuildContext context, Course course) {
    final theme = Theme.of(context);
    final model = context.read<TrainingModel>();
    final imageBytes = Uint8List.fromList(course.imageBytes!);

    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => model.navigateToCourseCreating(context, course.id),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 150,
                    decoration: const BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                         Radius.circular(5),
                      ),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      course.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}
