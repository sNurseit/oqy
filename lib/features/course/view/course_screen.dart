import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oqy/features/course/model/course_model.dart';
import 'package:oqy/features/course/widgets/course_module_list.dart';
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
    return CourseProvider(
      model: _model,
      child:  CourseDetails(courseId: widget.courseId),
    );
  }

  @override
  void dispose() async {
     _model.dispose();
    super.dispose();
  }
}


class CourseDetails extends StatelessWidget {
   final int courseId;

  const CourseDetails({Key? key, required this.courseId}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final course = CourseProvider.watch(context).model.course;


    if (course == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        title: Text(
          course.title ?? "",
          maxLines: 2,
          style: theme.textTheme.displayLarge,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView(
        children: <Widget>[
          Hero(
            tag: 'course_image_$courseId', 
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: Image.memory(
                Uint8List.fromList(course.imageBytes ?? []),
                fit: BoxFit.fitWidth,
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
          Center(
            child: Text(
              "${course.enrollmentCount} Students",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 20,
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
            course.price !=null ? 
            Text('${course.price}',style: theme.textTheme.labelMedium) 
            :const Text("Free"),
            FilledButton(
              onPressed: (){},
              child: Text('Buy now', style: theme.textTheme.displayLarge,)
            )
          ],
        ),
      ),
    );
  }
}