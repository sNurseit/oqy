import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/features/course_creating/bloc/question_edit_bloc/question_edit_bloc.dart';
import 'package:oqy/features/course_creating/bloc/quiz_edit_bloc/quiz_edit_bloc.dart';
import 'package:oqy/features/course_creating/widgets/question_edit_widget.dart';
import 'package:oqy/widgets/error_loading_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuizEditScreen extends StatefulWidget {
  final int id;
  final int courseId;
  const QuizEditScreen({required this.id, required this.courseId, super.key});

  @override
  State<QuizEditScreen> createState() => _QuizEditScreenState();
}

class _QuizEditScreenState extends State<QuizEditScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuizEditBloc>().add(LoadQuizEdit(
      id: widget.id,
      courseId: widget.courseId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuizEditBloc>();
    final questionBloc = context.read<QuestionEditBloc>();
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle))
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              bloc.add(LoadQuizEdit(courseId: widget.courseId,completer: completer,id: widget.id));
              return completer.future;
            },
            child: BlocBuilder<QuizEditBloc, QuizEditState>(
              builder: (context, state) {
                if (state is QuizEditLoaded) {
                  questionBloc.add( LoadQuestionEdit(quizId: widget.id, courseId:widget.courseId,editing: false)
                  );
                  return SingleChildScrollView(
                    physics: const ScrollPhysics(),

                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),

                        BlocBuilder<QuestionEditBloc, QuestionEditState>(
                          builder: (context, questionState) {
                            if(questionState is QuestionEditLoaded){
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: questionState.questions.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                                    child: QuestionEditWidget(
                                      question: questionState.questions[index],
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(child: CircularProgressIndicator(),);
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is QuizEditLoadingError) {
                  return Center(
                      child: ErrorLoadingWidget(
                    onTryAgain: () {},
                  ));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ));
  }
}
