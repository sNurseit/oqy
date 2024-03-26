
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/Course.dart';
import 'package:oqy/features/course/model/course_model.dart';
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
  late final CourseModel _model = CourseModel(courseId: widget.courseId);

  @override
  Widget build(BuildContext context) {
    return CourseProvider(
      model: _model,
      child: const CourseDetails(),
    );
  }
  @override
  void dispose() async {
     _model.dispose();
    super.dispose();
  }
}


class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});
 @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final course = CourseProvider.watch(context).model.course;


    if (course == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            
            pinned: true,
            forceElevated: true,
            floating: false,
            collapsedHeight: 80,
            expandedHeight: 250.0,
            toolbarHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                course.title ?? "",
                maxLines: 2,
                style: theme.textTheme.displayLarge,
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(Uint8List.fromList(course.imageBytes ?? [])),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        theme.scaffoldBackgroundColor,
                        Colors.transparent,
                      ],
                    
                    ),
                  ),
                ),
              ),
              stretchModes:const <StretchMode>[
                StretchMode.zoomBackground
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 80,
                child: Center(
                  child: Text(
                    "${course.enrollmentCount} Students",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              Center(

              )
            ]),
          ),
        ],
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