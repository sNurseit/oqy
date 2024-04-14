

import 'package:flutter/material.dart';
import 'package:oqy/features/training/model/training_model.dart';
import 'package:provider/provider.dart';

class MyTrainingListWidget extends StatelessWidget {
  const MyTrainingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final courses = context.read<TrainingModel>().courses;
    final model = context.read<TrainingModel>();
    final myContext = context;
    return  courses == null ? const CircularProgressIndicator() : ListView.builder(
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GestureDetector(
            
            onTap: ()=>model.navigateToCourseTraining(myContext, course.id),
            child: Card.filled(
              color: theme.cardColor,
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 480
                    ),
                    decoration: const BoxDecoration(
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                      child: Image.memory(
                        course.imageBytes,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                   Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: theme.textTheme.displayLarge,
                                ),
                                const SizedBox(height: 8,),
                                LinearProgressIndicator(
                                  value: 0.25,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(height: 4,),
                                Text(
                                  "Completed${5} out of ${course.materialCount ?? 0} ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}