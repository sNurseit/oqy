import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:provider/provider.dart';

class ReviewRatingWidget extends StatelessWidget {
  ReviewRatingWidget({ super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<CourseModel>();
    final userRating = model.userRating;
    final theme = Theme.of(context);
    return  RatingBar.builder(
      initialRating: userRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>  Icon(
        Icons.star,
        color: theme.primaryColor,
      ),
      onRatingUpdate: (rating) {
        model.updateUserRating(rating);
      },
    );
  }
}