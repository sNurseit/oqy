import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/answered_dto.dart';
import 'package:oqy/domain/entity/quiz.dart';

class QuizWidget extends StatefulWidget {
  final Quiz quiz;
  final Function(List<AnsweredDto>) onAnswered;
  const QuizWidget({required this.quiz, required this.onAnswered, super.key});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late List<AnsweredDto> _selectedAnswers;
  @override
  void initState() {
    super.initState();
    _initializeSelectedAnswers();
  }

  void _initializeSelectedAnswers() {
    _selectedAnswers = widget.quiz.questions != null
        ? List.generate(
            widget.quiz.questions!.length,
            (index) => AnsweredDto(questionId: widget.quiz.questions![index].id!, selectedAnswers: []),
          )
        : [];
  }

  void _onAnswerSelected(int questionIndex, int answerIndex) {
    final answerId = widget.quiz.questions![questionIndex].answers![answerIndex].id!;
    setState(() {
      if (_selectedAnswers[questionIndex].selectedAnswers.contains(answerId)) {
        _selectedAnswers[questionIndex].selectedAnswers.remove(answerId);
      } else {
        _selectedAnswers[questionIndex].selectedAnswers.add(answerId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.quiz.questions == null || widget.quiz.questions!.isEmpty) {
      return Center(
        child: Text('No questions available'),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quiz.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            for (var questionIndex = 0; questionIndex < widget.quiz.questions!.length; questionIndex++)
              if (widget.quiz.questions![questionIndex].answers != null &&
                  widget.quiz.questions![questionIndex].answers!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.quiz.questions![questionIndex].question!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var answerIndex = 0; answerIndex < widget.quiz.questions![questionIndex].answers!.length; answerIndex++)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: GestureDetector(
                                  onTap: () => _onAnswerSelected(questionIndex, answerIndex),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        width: 18,
                                        height: 18,
                                        curve: Curves.easeInOut,
                                        duration: const Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: _selectedAnswers[questionIndex].selectedAnswers.contains(widget.quiz.questions![questionIndex].answers![answerIndex].id) ? theme.primaryColor : theme.cardColor,
                                          border: Border.all(color: theme.primaryColor),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                          color: _selectedAnswers[questionIndex].selectedAnswers.contains(widget.quiz.questions![questionIndex].answers![answerIndex].id) ? theme.primaryColor : theme.cardColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(widget.quiz.questions![questionIndex].answers![answerIndex].answerText!),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                  GestureDetector(
                    onTap: () =>widget.onAnswered(_selectedAnswers),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: theme.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8),
                        child: Text('Answer', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
                      )
                    ),
                  )          
                ],
        ),
      ),
    );
  }
}
