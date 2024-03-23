import 'package:flutter/material.dart';
import 'package:oqy/features/home/model/home_model.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListCourses extends StatelessWidget {
  const ListCourses({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider.value(
      value: HomeModel(),
      child: const ListCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<HomeModel>(context).model;
    final model = Provider.of<HomeModel>(context);
    final width = MediaQuery.of(context).size.width;
    final height = width*9/16;
    final theme = Theme.of(context);
    if (courses == null || courses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(

      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GestureDetector(
            
            onTap: ()=>model.navigateToCourseDetails(context, course.id, course.title),
            child: Card.filled(
              margin: const EdgeInsets.all(16),
              color: theme.cardColor,
              child: Column(
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                      child: Image.memory(
                        course.imageBytes,
                        fit: BoxFit.cover,
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