import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/domain/entity/review.dart';
import 'package:oqy/theme/app_colors.dart';

class CommentBottomSheet extends StatefulWidget {
  final List<Review>? reviews;

  CommentBottomSheet({required this.reviews, Key? key}) : super(key: key);

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  double _userRating = 0.0;
  final _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: AppBar(
            automaticallyImplyLeading:false,
            backgroundColor: Colors.transparent,
            titleTextStyle: theme.textTheme.bodyMedium,
            centerTitle: true,
            title: const Text('Reviews'),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: widget.reviews == null || widget.reviews!.isEmpty 
          ?  Center(
            child:Text(
              'No reviews',
              style: theme.textTheme.bodyMedium,
            )
          ) 
          : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.reviews!.length,
            itemBuilder: (context, index) {
              final review = widget.reviews![index];
              return ListTile(
                title: Text(review.fullName ?? '', style: theme.textTheme.displayMedium,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: review.rating!.toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: AppFontColors.fontLink,
                          ),
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                          unratedColor: theme.unselectedWidgetColor,
                        ),
                        Text(review.dispatchDate ?? ''),
                      ],
                    ),
                    Text(review.review ?? ''),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: keyboardHeight > 0 ? keyboardHeight + 20.0 : 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              RatingBar.builder(
                initialRating: _userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppFontColors.fontLink,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _userRating = rating;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _textFieldFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Add a comment',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
