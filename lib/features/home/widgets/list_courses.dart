import 'package:flutter/material.dart';
import 'package:oqy/features/home/model/course_list_model.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListCourses extends StatelessWidget {
  const ListCourses({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider.value(
      value: HomeListModel(),
      child: const ListCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeListModel>(context);
    final courses = model.model;
    final myContext = context;
    final theme = Theme.of(context);
    if (courses == null || courses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(

      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GestureDetector(
            
            onTap: ()=>model.navigateToCourseDetails(myContext, course.id),
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
                      child: Hero(
                        tag: 'course_image_${course.id}',
                        child: Image.memory(
                          course.imageBytes,
                          fit: BoxFit.fitWidth,
                        ),
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
                                      itemSize: 24.0,
                                      direction: Axis.horizontal,
                                      unratedColor: theme.unselectedWidgetColor,
                                    ),
                                    Text('${course.price}',
                                      style: theme.textTheme.labelMedium
                                    ),
                                  ],
                                )
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