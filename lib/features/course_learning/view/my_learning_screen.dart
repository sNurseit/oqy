import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/features/course_learning/bloc/course_learning_bloc/course_learning_bloc.dart';
import 'package:oqy/widgets/custom_list_tile.dart';

@immutable
@RoutePage()
class MyLearningScreen extends StatefulWidget {
  final int courseId;
  const MyLearningScreen({
    Key? key,
    @PathParam() required this.courseId,
  }) : super(key: key);

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CourseLearningBloc>()
        .add(LoadCourseLearning(courseId: widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final learningBloc = context.read<CourseLearningBloc>();

    return Scaffold(
      appBar: AppBar(
        title:BlocBuilder<CourseLearningBloc, CourseLearningState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            maxLines: 2,
                            state is CourseLearningLoaded
                                ? state.course.title!
                                : 'Loading',
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
      ),
          body:BlocBuilder<CourseLearningBloc, CourseLearningState>(
            builder: (context, state) {
              if(state is CourseLearningLoaded){
                final course = state.course;
                final modules = state.course.modules;
                final quizzes = state.course.quizzes;
                final onlineLessons = state.course.onlineLessons;
                final combinedItems = [...?modules, ...?quizzes];
                combinedItems.sort((a, b) => a.step.compareTo(b.step));

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(course.onlineLessons!.isNotEmpty) ...[
                        const Text('Online lessons'),
                      ],
                      if (course.modules!.isNotEmpty) ...[
                        const SizedBox(height: 15,),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: onlineLessons?.length,
                            itemBuilder: (context, index) {
                              final item = onlineLessons?[index];
                              return Column(
                                children: [
                                  Container(
                                      color: theme.cardColor,
                                      child: CustomListTile(
                                        icon: Icons.video_call_outlined,
                                        title: item!.title!,
                                        trailing: true,
                                        onTap: () =>learningBloc.add(NavigateToOnlineLesson(context: context, courseId: widget.courseId, onlineLesson: item)),
                                      ),
                                    ),
                                  if (index < combinedItems.length - 1)
                                    Divider(
                                      color: Colors.grey[300],
                                      thickness: 1.0,
                                      height: 0,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                          child: Text('Modules', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18)),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: combinedItems.length,
                            itemBuilder: (context, index) {
                              final item = combinedItems[index];
                              return Column(
                                children: [
                                  Container(
                                      color: theme.cardColor,
                                      child: CustomListTile(
                                        icon: item is Module ? Icons.view_module_outlined : Icons.quiz_outlined,
                                        title: item.title,
                                        trailing: true,
                                        onTap: () =>learningBloc.add(NavigateToModule(context: context, module: item)),
                                      ),
                                    ),
                                  if (index < combinedItems.length - 1)
                                    Divider(
                                      color: Colors.grey[300],
                                      thickness: 1.0,
                                      height: 0,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }
          )
      );
  }
}
