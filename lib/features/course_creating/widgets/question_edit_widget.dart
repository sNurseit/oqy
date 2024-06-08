import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/answer.dart';
import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/features/course_creating/bloc/question_edit_bloc/question_edit_bloc.dart';
import 'package:oqy/features/course_creating/widgets/answer_edit_widget.dart';
import 'package:oqy/widgets/photo_loader_widget.dart';
import 'package:provider/provider.dart';

class QuestionEditWidget extends StatefulWidget {
  final Question? question;
  const QuestionEditWidget({required this.question, super.key});

  @override
  State<QuestionEditWidget> createState() => _QuestionEditWidgetState();
}

class _QuestionEditWidgetState extends State<QuestionEditWidget> {
  TextEditingController questionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      questionTextController.text = widget.question!.question!;
    }
  }

  void updateAnswer(int index, Answer answer) {
    setState(() {
      for (int i = 0; i < widget.question!.answers!.length; i++) {
        if (i != index) {
          widget.question!.changed = true;
          widget.question!.answers![i].correct = false;
        }
      }
      widget.question!.answers![index] = answer;
    });
  }

  void deleteAnswer(int answerId){
    setState(() {
      widget.question!.changed = true;
      widget.question?.answers?.removeWhere((answer) => answer.id == answerId);
    });
  }

  void createAnswer() {
    setState(() {
      widget.question!.changed = true;
      widget.question?.answers?.add(Answer());
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuestionEditBloc>();
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: theme.cardColor,
        border: questionTextController.text != widget.question?.question
            ? Border.all(color: theme.primaryColor)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.question != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: theme.cardColor,
                    ),
                    width: 50,
                    height: 50,
                    child: PhotoLoader(
                      onPhotoSelected: (base64Photo) {
                        setState(() {
                          widget.question!.image = base64Photo;
                        });
                      },
                      notSelected: const Icon(Icons.image),
                    ),
                  ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: 'Question',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: theme.scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    ),
                    controller: questionTextController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('Answers'),
            if (widget.question != null) ...[
              for (int i = 0; i < widget.question!.answers!.length; i++)
                AnswerEdit(
                  answer: widget.question!.answers![i],
                  onChanged: (answer) => updateAnswer(i, answer),
                ),
            ],
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Add answer', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14)),
                  )
                ),
                onTap: () => createAnswer(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: theme.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8),
                        child: Text('Save', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
