import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc.dart';
import 'package:oqy/features/course_creating/widgets/course_creating_drawer_widget.dart';
import 'package:oqy/features/course_creating/widgets/searchable_dropdown_widget.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';
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
  final _courseCreatingBloc = CourseCreatingBloc(courseService: GetIt.I<CourseService>(), courseCategoryService: GetIt.I<CourseCategoryService>());
  CourseCategory? _selectedCategory;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _languageController = TextEditingController();
  final _priceController = TextEditingController();
  String? picture;
  @override
  void initState() {
    super.initState();
    _courseCreatingBloc.add(LoadCourseCreating(courseId: widget.courseId));
  }

  @override
  Widget build(BuildContext context) {  
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              _courseCreatingBloc.add(LoadCourseCreating(completer:completer));
              return completer.future;
            },
            child: BlocBuilder<CourseCreatingBloc, CourseCreatingState>(
              bloc: _courseCreatingBloc,
              builder: (context, state) {
                if(state is CourseCreatingLoaded){
                  final course = state.course;
                  _titleController.text = course?.title ?? '';
                  _descriptionController.text = course?.description ?? '';
                  _languageController.text = course?.language ?? '';
                  _priceController.text = course?.price ?? '';
                  return ListView(
                    children: [
                      const SizedBox(height: 20),
                      PhotoLoader(
                        onPhotoSelected: (base64Photo) {
                          picture = base64Photo;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Title *'),
                      const SizedBox(height: 10),
                      TextField(controller: _titleController),
                      const SizedBox(height: 20),
                      const Text('Description *'),
                      const SizedBox(height: 10),
                      TextField(controller: _descriptionController),
                      const SizedBox(height: 20),
                      const Text('Language *'),
                      const SizedBox(height: 10),
                      TextField(controller: _languageController),
                      const SizedBox(height: 20),
                      const Text('Price *'),
                      const SizedBox(height: 10),
                      TextField(controller: _priceController),
                      const SizedBox(height: 20),
                      const Text('Type *'),
                      const SizedBox(height: 10),
                      CategoryDropDown(
                        categories: state.category,
                        onCategorySelected: (selectedCategory) {
                          _selectedCategory = selectedCategory;
                        },
                      ),
                    ],
                  );
                }
                if(state is CourseCreatingError){
                  return ErrorLoadingWidget(
                    onTryAgain: () => _courseCreatingBloc.add(LoadCourseCreating()),
                  );
                }
                return const CircularProgressIndicator();
              }
            ),
          ),
        ),
      ),
      endDrawer: const CourseCreatingDrawerWidget(index: -1,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final course = Course(
            image: picture,
            title: _titleController.text,
            description: _descriptionController.text,
            language: _languageController.text,
            price: _priceController.text,
            categoryCode: _selectedCategory?.code,
          );
          final inputValidations = _courseCreatingBloc.validateInput(course);
          if (inputValidations.isNotEmpty) {
            _showValidationErrors(inputValidations);
          } else {
            _courseCreatingBloc.add(PostCourseMainInformation(course: course));
          }
        },
        child: const Icon(Icons.save),
      ),
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