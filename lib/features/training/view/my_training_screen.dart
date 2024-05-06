import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:oqy/features/training/model/my_training_model.dart';
import 'package:oqy/features/training/widgets/course_modules.dart';
import 'package:provider/provider.dart';

@immutable
@RoutePage()
class MyTrainingScreen extends StatefulWidget {
  final int courseId;
  const MyTrainingScreen({
    Key? key,
    @PathParam() required this.courseId,
  }) : super(key: key);

  @override
  State<MyTrainingScreen> createState() => _MyTrainingScreenState();
}

class _MyTrainingScreenState extends State<MyTrainingScreen> {
  late final MyTrainingModel _model;

  @override
  void initState() {
    super.initState();
    _model = MyTrainingModel(courseId: widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>_model,
      child:  MyTraining(courseId: widget.courseId),
    );
  }

}


class MyTraining extends StatelessWidget {
  final int courseId;
  const MyTraining({required this.courseId, super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final course = context.watch<MyTrainingModel>().course;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        title: Text(
          course == null ? " ": '${course.id} ${course.title} ',
          maxLines: 2,
          style: theme.textTheme.displayLarge,
        ),
      ),
    
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CourseModules(),
    );
  }
}
