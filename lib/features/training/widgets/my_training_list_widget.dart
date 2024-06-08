import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oqy/features/training/model/training_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyTrainingListWidget extends StatelessWidget {
  const MyTrainingListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final courses = context.read<TrainingModel>().courses;
    final model = context.read<TrainingModel>();
    final myContext = context;

    return courses == null
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                final course = courses[index];
                final imageBytes = Uint8List.fromList(course.imageBytes!);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: GestureDetector(
                    onTap: () => model.navigateToCourseTraining(myContext, course.id),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: Image.memory(
                              imageBytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
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
                                const SizedBox(height: 8),
                                Text(
                                  course.description,
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14, ),
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
