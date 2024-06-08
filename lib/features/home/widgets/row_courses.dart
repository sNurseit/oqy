import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/features/home/model/home_model.dart';
import 'package:provider/provider.dart';

class RowCourses extends StatelessWidget {
  const RowCourses({super.key});
  static Widget create() {
    return ChangeNotifierProvider.value(
      value: HomeModel(),
      child: const RowCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    final courses = model.topCourses;
    final theme = Theme.of(context);

    if (courses == null || courses.isEmpty) {
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('Top 10 courses', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        SizedBox(
          height: 250, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int index) {
              final course = courses[index];
              return _buildCourseItem(context, course);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseItem(BuildContext context, Course course) {
    final theme = Theme.of(context);
    final model = context.read<HomeModel>();
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
              onTap: () => model.navigateToCourseDetails(context, course.id!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 150, // Reduced height to fit within the ListView
                    decoration: const BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      child: Hero(
                        tag: 'course_image_${course.id}',
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      course.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBarIndicator(
                    rating: course.averageRating ?? 0.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: theme.primaryColor,
                    ),
                    unratedColor: Colors.grey,
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
