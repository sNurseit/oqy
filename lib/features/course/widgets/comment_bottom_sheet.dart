import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/review_rating.dart';
import 'package:provider/provider.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController reviewTextEditingController = TextEditingController();
  FocusNode reviewFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final model = context.read<CourseModel>();
    final reviews = model.reviews;
    final theme = Theme.of(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            titleTextStyle: theme.textTheme.bodyMedium,
            centerTitle: true,
            title: const Text('Reviews'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: reviews == null || reviews!.isEmpty
              ? Center(
                  child: Text(
                    'No reviews',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews!.length,
                  itemBuilder: (context, index) {
                    final review = reviews![index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text(
                          review.fullName ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: review.rating!.toDouble(),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: theme.primaryColor,
                                  ),
                                  itemCount: 5,
                                  itemSize: 24.0,
                                  direction: Axis.horizontal,
                                  unratedColor: theme.unselectedWidgetColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  review.dispatchDate ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              review.review ?? '',
                              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: theme.focusColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 3,
              ),
            ],
            color: theme.cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: keyboardHeight > 0 ? keyboardHeight + 20.0 : 8.0,
              top: 10,
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReviewRatingWidget(),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: reviewTextEditingController,
                        focusNode: reviewFocusNode,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: 'Add a comment',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.send_rounded),
                      onPressed: () {
                        if (reviewTextEditingController.text.isNotEmpty) {
                          model.addReview(reviewTextEditingController.text);
                          reviewTextEditingController.clear();
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
