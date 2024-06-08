import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/answer.dart';
import 'package:oqy/widgets/photo_loader_widget.dart';

class AnswerEdit extends StatefulWidget {
  final Answer answer;
  final ValueChanged<Answer> onChanged;

  const AnswerEdit({required this.answer, required this.onChanged, super.key});

  @override
  State<AnswerEdit> createState() => _AnswerEditState();
}

class _AnswerEditState extends State<AnswerEdit> {
  late TextEditingController answerController;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    answerController = TextEditingController(text: widget.answer.answerText);
    isCorrect = widget.answer.correct ?? false;
    answerController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    answerController.removeListener(_onTextChanged);
    answerController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.answer.answerText = answerController.text;
    widget.onChanged(widget.answer);
  }

  void _onImageChanged(String photo) {
    widget.answer.image = photo;
    widget.onChanged(widget.answer);
  }

  void _onCorrectChanged(bool? value) {
    setState(() {
      isCorrect = value ?? false;
      widget.answer.correct = isCorrect;
      widget.onChanged(widget.answer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
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
                          widget.answer.image = base64Photo;
                        });
                      },
                      notSelected: const Icon(Icons.image),
                    ),
                  ),
        Flexible(
          child: TextField(
            maxLines: 5,
            minLines: 1,
            controller: answerController,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: 'Answer text',
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
          ),
        ),
        Checkbox(
          value: isCorrect,
          onChanged: _onCorrectChanged,
        ),
        IconButton(icon: const Icon(Icons.delete), onPressed: (){},)
      ],
    );
  }
}
