import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddModuleButtomSheet extends StatefulWidget {
  final StepItem? stepItem;

  const AddModuleButtomSheet({this.stepItem, Key? key,}) : super(key: key);

  @override
  _AddModuleButtomSheetState createState() => _AddModuleButtomSheetState();
}

class _AddModuleButtomSheetState extends State<AddModuleButtomSheet> {
  int _selectedIndex = 0;

  void _closeBottomSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courseCreatingBloc = Provider.of<CourseCreatingBloc>(context, listen: false);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    if(widget.stepItem!=null){
      titleController.text = widget.stepItem!.title;
      descriptionController.text = widget.stepItem!.description ?? '';
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: BlocBuilder<CourseCreatingBloc, CourseCreatingState>(
              builder: (context, state) {
                  return IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 45,),
                              const Text('Module'),
                              GestureDetector(
                                child: const Icon(Icons.close_outlined),
                                onTap: () => _closeBottomSheet(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            labelText: 'Title',
                            maxLines: 1,
                            maxLength: 50,
                            hintText: 'Enter title',
                            controller: titleController,
                            onChanged: (value) {
                              titleController.text = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            labelText: 'Description',
                            maxLines: 3,
                            maxLength: 200,
                            hintText: 'Enter description',
                            controller: descriptionController,
                            onChanged: (value) {
                              descriptionController.text = value;
                            },
                          ),
                        ),
                        if(widget.stepItem==null) ...[
                          const SizedBox(height: 10),
                          ModuleTypes(
                            selectedIndex: _selectedIndex,
                            onSelectItem: (index) {
                              _selectedIndex = index;
                            },
                          ),
                        ],
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: FloatingActionButton.extended(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              onPressed: () {
                                if (titleController.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty) {
                                  if(widget.stepItem!=null){
                                    if(widget.stepItem is Quiz){
                                      _selectedIndex = 1;
                                    }
                                    else if(widget.stepItem is Module){
                                       _selectedIndex = 0;

                                    }
                                  }
                                  courseCreatingBloc.add(
                                    AddModule(
                                      context: context,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      type: _selectedIndex,
                                      id: widget.stepItem?.id,
                                      step: widget.stepItem?.step,
                                    ),
                                  );
                                }
                              },
                              label: widget.stepItem == null ? const Text(
                                "Add",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ):
                              const Text(
                                "Save changes",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              icon:  widget.stepItem == null ? const Icon(Icons.add, color: Colors.white,)
                              : const Icon(Icons.save_rounded, color: Colors.white,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            ),
          ),
        );
      },
    );
  }
}

class ModuleTypes extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectItem;

  const ModuleTypes({
    Key? key,
    required this.selectedIndex,
    required this.onSelectItem,
  }) : super(key: key);

  @override
  State<ModuleTypes> createState() => _ModuleTypesState();
}

class _ModuleTypesState extends State<ModuleTypes> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onSelectItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          _buildSelectableItem(0, 'Default module', Icons.view_module),
          const SizedBox(width: 10),
          _buildSelectableItem(1, 'Quiz', Icons.quiz_rounded),
          const SizedBox(width: 10),
          _buildSelectableItem(2, 'Online lesson', Icons.video_call),
         const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildSelectableItem(int index, String content, IconData icon) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _selectItem(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          border: Border.all(color: theme.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Icon(icon ),
              SizedBox(width: 5,),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ]
          ),
          
        ),
      ),
    );
  }
}
