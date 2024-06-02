import 'package:flutter/material.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/comment_bottom_sheet.dart';
import 'dart:math';
import 'package:provider/provider.dart';
class HorizontalCommentScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final reviews = context.read<CourseModel>().reviews;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: CommentBottomSheet(
              reviews: reviews,
            ),
          ),
        );
      },
      child:  SizedBox(
        height: 300.0,
        child: reviews!=null ? ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: min(reviews.length, 3),
          itemBuilder: (context, index) {
            return Container(
              width: 200.0,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8.0),
                        Text(
                          reviews[index].fullName!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      reviews[index].dispatchDate!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      reviews[index].review!
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Points: ${reviews[index].rating}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ):
        Container()
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