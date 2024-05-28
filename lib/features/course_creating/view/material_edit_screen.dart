import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/widgets/custom_text_field.dart';

@RoutePage()
class MaterialEditScreen extends StatefulWidget {
  final int materialStep;
  final int moduleStep;

  const MaterialEditScreen({
    Key? key,
    required this.materialStep,
    required this.moduleStep,
  }) : super(key: key);

  @override
  State<MaterialEditScreen> createState() => _MaterialEditScreenState();
}

class _MaterialEditScreenState extends State<MaterialEditScreen> {
  final titleController = TextEditingController();
  late QuillController quillController;

  @override
  void initState() {
    super.initState();
    context.read<CourseCreatingBloc>().add(LoadMaterial(
          step: widget.materialStep,
          moduleStep: widget.moduleStep,
        ));
  }


  @override
  Widget build(BuildContext context) {
    final courseCreatingBloc = context.read<CourseCreatingBloc>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CourseCreatingBloc, CourseCreatingState>(
        builder: (context, state) {
          if (state is MaterialLoaded) {
            print('material loaded');
            final material = state.material;
            quillController = QuillController.basic();
            return ListView(
              children: [
                CustomTextField(
                  labelText: "Title",
                  hintText: 'Enter title',
                  maxLines: 1,
                  maxLength: 50,
                  controller: titleController,
                ),
                if (material.type == 'text') ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillToolbar.simple(
                      configurations: QuillSimpleToolbarConfigurations(
                        controller: quillController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('ru'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: quillController,
                          readOnly: false,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('ru'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text('Select Image'),
                  ),
                ] else
                  Text('Video'),
              ],
            );
          } else if (state is MaterialLoadingError) {
            return Text(state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
