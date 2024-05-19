import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/course_module_list.dart';
import 'package:oqy/features/course/widgets/horizontal_comment.dart';
import 'package:oqy/theme/app_colors.dart';
import 'package:provider/provider.dart';
@immutable
@RoutePage()  
class CourseScreen extends StatefulWidget {
  final int courseId;

  const CourseScreen({
    Key? key,
    @PathParam() required this.courseId,
  }) : super(key: key);



  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseModel _model;

  @override
  void initState() {
    super.initState();
     _model = CourseModel(courseId: widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>_model,
      child:  CourseDetails(courseId: widget.courseId),
    );
  }


}


class CourseDetails extends StatefulWidget {
  final int courseId;

  const CourseDetails({Key? key, required this.courseId}) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
 @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final course = context.watch<CourseModel>().course;
    final model = context.read<CourseModel>();
    final scrollController = ScrollController();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        title: Text(
          course == null ? " ": course.title,
          maxLines: 2,
          style: theme.textTheme.displayLarge,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: course == null ? const Center(child: CircularProgressIndicator()) 
      : ListView(
        controller: scrollController,
        children: <Widget>[
          Hero(
            tag: 'course_image_${widget.courseId}', 
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: InteractiveViewer(
                child: Image.memory(
                  Uint8List.fromList(course.imageBytes ?? []),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), 
            child: Column(
              children: [
                Text(
                  course.title ?? "",
                  maxLines: 3,
                  style: theme.textTheme.titleMedium,
                ),
                Row(
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
                      const SizedBox(width: 10,),
                      Text("${course.averageRating}(${course.reviewCount})", style: theme.textTheme.displaySmall,),
                  
                    ],
                  ),
                
                const SizedBox(
                  height: 20,
                ),
                Text(course.description, maxLines: 5,),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HorizontalCommentScroll(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Study plan:", style: theme.textTheme.displayLarge,),
                Text("${course.moduleCount} mudles, ${course.quizCount ?? 0} quizes, ${course.materialCount ?? 0} materials"),
              ],
            )
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child:  CourseModelList(),
          ),
        ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.secondaryHeaderColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            course != null? 
            Text('${course.price}',style: theme.textTheme.labelMedium) 
            :const Text("Free"),
            FilledButton(
              onPressed:() => model.buyCourse(course.id, context),
              child: Text('Buy now', style: theme.textTheme.displayLarge,)
            )
          ],
        ),
      ),
    );
  }
}