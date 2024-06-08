import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/dto/answered_dto.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/features/course_learning/bloc/module_learn_bloc/moudle_learn_bloc.dart';
import 'package:oqy/features/course_learning/widgets/material_learn_widget.dart';
import 'package:oqy/features/course_learning/widgets/quiz_widget.dart';
import 'package:oqy/features/course_learning/widgets/video_widget.dart';
import 'package:oqy/widgets/custom_list_tile.dart';
import 'package:oqy/widgets/error_loading_widget.dart';

@RoutePage()
class ModuleLearnScreen extends StatefulWidget {
  final StepItem module;
  final int materialIndex;
  const ModuleLearnScreen(
      {required this.module, required this.materialIndex, super.key});

  @override
  State<ModuleLearnScreen> createState() => _ModuleLearnState();
}

class _ModuleLearnState extends State<ModuleLearnScreen> {
  void receiveAnswers(List<AnsweredDto> answers) {
    context.read<ModuleLearnBloc>().add(CheckQuiz(
        quizId: widget.module.id!, answers: answers, context: context));
  }

  @override
  void initState() {
    super.initState();
    context.read<ModuleLearnBloc>().add(LoadModuleLearn(
        module: widget.module, materialIndex: widget.materialIndex));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moduleBloc = context.read<ModuleLearnBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ModuleLearnBloc, ModuleLearnState>(
        builder: (context, state) {
          if (state is QuizLearnLoaded) {
            return QuizWidget(
              quiz: state.quiz,
              onAnswered: receiveAnswers,
            );
          } else if (state is MaterialLearnLoaded) {
            return MaterialLearnWidget(material: state.currentMaterial);
          } else if (state is VideoLearnLoaded) {
            return VideoWidget(
              material: state.currentMaterial,
              video: state.video,
            );
          } else if (state is ModuleLearnLoadingError) {
            return Center(
              child: ErrorLoadingWidget(
                onTryAgain: () => moduleBloc.add(LoadModuleLearn(
                    module: widget.module,
                    materialIndex: widget.materialIndex)),
              ),
            );
          } else if (state is QuizAnswered) {
            return Center(
              child: Text('points: ${state.points}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      endDrawer: Drawer(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: BlocBuilder<ModuleLearnBloc, ModuleLearnState>(
              builder: (context, state) {
                if (state is VideoLearnLoaded) {
                  return Column(
                    children: [
                        for(int i = 0; i < state.materials.length; i++) ...[
                          const Text('text'),
                          CustomListTile(
                            icon: state.materials[i].type == 'text' ? Icons.text_fields_rounded : Icons.play_circle_fill_rounded,
                            title: state.materials[i].title ?? 'Unknown Material', 
                            onTap: () => moduleBloc.add(LoadModuleLearn( module: widget.module, materialIndex: i)),
                            trailing: false
                          )
                        ]
                    ],
                  );
                } 
                return const Text('no');
              }
               
            ),
          ),
        ),
      ),
    );
  }
}
