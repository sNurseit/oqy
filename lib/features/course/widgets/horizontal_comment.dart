import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'dart:math';
import 'package:provider/provider.dart';
class HorizontalCommentScroll extends StatelessWidget {
  const HorizontalCommentScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = context.read<CourseModel>().reviews;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: theme.cardColor,
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const  EdgeInsets.all(16.0),
            child:  Text(
              'Reviews',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          reviews == null || reviews.isEmpty
          ?Padding(
            padding: const  EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
            child: Center(
              child: Opacity(
                opacity: 0.7,
                child: Text(
                  'No reviews',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
          :Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              height: 165.0,  
              child: reviews!=null ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: min(reviews.length, 3),
                itemBuilder: (context, index) {
                  return Container(
                    width: 270.0,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviews[index].fullName!,
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, ),
                          ),
                          Text(
                            reviews[index].dispatchDate!,
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14, ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RatingBarIndicator(
                                rating: reviews[index].rating.toDouble(),
                                itemBuilder: (context, index) =>  Icon(
                                  Icons.star,
                                  color: theme.primaryColor,
                                ),
                                itemCount: 5,
                                itemSize: 24.0,
                                direction: Axis.horizontal,
                                unratedColor: theme.unselectedWidgetColor,
                              ),
                              const SizedBox(height: 20.0),
            
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${reviews[index].review!}',
                            maxLines: 3,
                          ),
                          
                        ],
                      ),
                    ),
                  );
                },
              ):
              Container()
            ),
          ),
        ],
      ),
    );
  }
}



/*
Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: reviews!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(reviews![index]!.fullName ?? ''),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reviews![index]!.dispatchDate ?? ''),
                                  Text(reviews![index]!.review ?? ''),
                                  Text('Points: ${reviews![index]!.rating}'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                             Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Add a comment',
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                // Обработка нажатия кнопки отправки комментария
                              },
                              child: Text('Send'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

*/