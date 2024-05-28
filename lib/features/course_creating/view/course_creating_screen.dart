import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/features/course_creating/widgets/course_creating_drawer_widget.dart';
import 'package:oqy/features/course_creating/widgets/searchable_dropdown_widget.dart';
import 'package:oqy/widgets/custom_switch_list_tile.dart';
import 'package:oqy/widgets/custom_text_field.dart';
import 'package:oqy/widgets/error_loading_widget.dart';
import 'package:oqy/widgets/photo_loader_widget.dart';

@RoutePage()
class CourseCreatingScreen extends StatefulWidget {
  final int courseId;

  const CourseCreatingScreen({super.key, required this.courseId});

  @override
  State<CourseCreatingScreen> createState() => _CourseCreatingScreenState();
}

class _CourseCreatingScreenState extends State<CourseCreatingScreen> {
  CourseCategory? _selectedCategory;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _languageController = TextEditingController();
  final _priceController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();

  bool _onlineLesson = false;
  String? picture;

  @override
  void initState() {
    super.initState();
    context.read<CourseCreatingBloc>().add(LoadCourseCreating(courseId: widget.courseId));
    _titleFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final courseCreatingBloc = context.read<CourseCreatingBloc>();
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            style:  ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final course = Course(
                image: picture,
                title: _titleController.text,
                description: _descriptionController.text,
                language: _languageController.text,
                price: _priceController.text,
                categoryCode: _selectedCategory?.code,
              );
              final inputValidations = courseCreatingBloc.validateInput(course);
              if (inputValidations.isNotEmpty) {
                _showValidationErrors(inputValidations);
              } else {
                courseCreatingBloc.add(PostCourseMainInformation(course: course));
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        )
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 8),
          child: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              courseCreatingBloc.add(LoadCourseCreating(courseId: widget.courseId, completer: completer));
              return completer.future;
            },
            child: BlocBuilder<CourseCreatingBloc, CourseCreatingState>(
              builder: (context, state) {
                if (state is CourseCreatingLoaded) {
                  final course = state.course;
                  if (course != null) {
                    _titleController.text = course.title?? '';
                    _descriptionController.text = course.description?? '';
                    _languageController.text = course.language?? '';
                    _priceController.text = course.price?? '';
                  }
                  return ListView(
                    children: [
                      const SizedBox(height: 10),
                      PhotoLoader(
                        onPhotoSelected: (base64Photo) {
                          picture = base64Photo;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Title', 
                        maxLines: 1, 
                        maxLength: 50, 
                        hintText: 'Enter title', 
                        controller: _titleController,
                        onChanged: (value) {
                          _titleController.text = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Descirption', 
                        maxLines: 5, 
                        maxLength: 200, 
                        hintText: 'Enter descirption', 
                        controller: _descriptionController,
                        onChanged: (value) {
                          _descriptionController.text = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Language', 
                        maxLines: 1, 
                        maxLength: 50, 
                        hintText: 'Enter language', 
                        controller: _languageController,
                        onChanged: (value) {
                          _languageController.text = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Price', 
                        maxLines: 1, 
                        maxLength: 6, 
                        hintText: 'Enter price', 
                        controller: _priceController,
                        onChanged: (value) {
                          _priceController.text = value;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const Text('Type *'),
                      const SizedBox(height: 10),
                      CategoryDropDown(
                        categories: state.category,
                        onCategorySelected: (selectedCategory) {
                          _selectedCategory = selectedCategory;
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      CustomSwitch(
                        value: _onlineLesson,
                        onChanged: (bool value) {
                          setState(() {
                            _onlineLesson = value;
                          });
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                }
                if (state is CourseCreatingError) {
                  return ErrorLoadingWidget(
                    onTryAgain: () => courseCreatingBloc.add(LoadCourseCreating(courseId: widget.courseId)),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
      endDrawer:  CourseCreatingDrawerWidget( index: -1),
    );
  }

  void _showValidationErrors(Map<String, String> inputValidations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Errors'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: inputValidations.entries.map((entry) => Text(entry.value)).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _languageController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
