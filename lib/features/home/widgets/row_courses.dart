

import 'package:flutter/material.dart';
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
    final courses = model.model;
    final myContext = context;
    final theme = Theme.of(context);

    if (courses == null || courses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Text('Top 10 courses'),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int index) {
              final course = courses[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: ()=>model.navigateToCourseDetails(myContext, course.id),
                  child: Card.filled(
                    color: theme.cardColor,
                    child: Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 200,
                            minHeight: 120,
                            minWidth: 200,
                            maxWidth: 200,
                          ),
                          decoration: const BoxDecoration(
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                            child: Hero(
                              tag: 'course_image_${course.id}',
                              child: Image.memory(
                                course.imageBytes,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                       /* Padding(
                          padding: const EdgeInsets.all(8),
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
                                    ),
                                    const SizedBox(height: 8,),
                                    Text(
                                      course.description,
                                      maxLines: 2,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RatingBarIndicator(
                                          rating: course.averageRating,
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: AppFontColors.fontLink,
                                          ),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          direction: Axis.horizontal,
                                          unratedColor: theme.unselectedWidgetColor,
                                        ),
                                        Text('${course.price}',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              
                            ],
                          
                          ),
                        ),*/
                      ],
                    ),
                  ),
                )
              );
            }
          ),
        ),
      ],
    );
  }
}