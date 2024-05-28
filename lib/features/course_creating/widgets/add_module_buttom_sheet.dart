import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddModuleButtomSheet extends StatefulWidget {
  final StepItem? stepItem;
  const AddModuleButtomSheet({this.stepItem, Key? key}) : super(key: key);

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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10),
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
                        CustomTextField(
                          labelText: 'Title',
                          maxLines: 1,
                          maxLength: 50,
                          hintText: 'Enter title',
                          controller: titleController,
                          onChanged: (value) {
                            titleController.text = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          labelText: 'Description',
                          maxLines: 3,
                          maxLength: 200,
                          hintText: 'Enter description',
                          controller: descriptionController,
                          onChanged: (value) {
                            descriptionController.text = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        ModuleTypes(
                          selectedIndex: _selectedIndex,
                          onSelectItem: (index) {
                            _selectedIndex = index;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (titleController.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty) {
                                courseCreatingBloc.add(
                                  AddModule(
                                    context: context,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    type: _selectedIndex,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSelectableItem(0, 'Default module'),
        const SizedBox(width: 10),
        _buildSelectableItem(1, 'Quiz'),
        const SizedBox(width: 10),
        _buildSelectableItem(2, 'Online lesson'),
      ],
    );
  }

  Widget _buildSelectableItem(int index, String content) {
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
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
