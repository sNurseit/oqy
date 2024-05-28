import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/features/course_creating/widgets/add_module_buttom_sheet.dart';

class CourseCreatingDrawerWidget extends StatelessWidget {
  final int index;
  CourseCreatingDrawerWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseCreatingBloc = context.read<CourseCreatingBloc>();

    final theme = Theme.of(context);
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: theme.cardColor,
      child: BlocBuilder<CourseCreatingBloc, CourseCreatingState>(
        builder: (context, state) {
          if (state is CourseCreatingLoaded) {
            final modules = state.course!.modules;
            final quizzes = state.course!.quizzes;

            final combinedItems = [...?modules, ...?quizzes];
            combinedItems.sort((a, b) => a.step.compareTo(b.step));

            return Column(
              children: [
                DrawerHeader(
                  child: Container( 
                    width: double.infinity,
                    color: const Color.fromARGB(255, 179, 199, 187),
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = combinedItems.removeAt(oldIndex);
                      combinedItems.insert(newIndex, item);
                    },
                    children: [
                      for (int index = 0; index < combinedItems.length; index++)
                        ListTile(
                          key: ValueKey(combinedItems[index].step),
                          leading: Icon(
                            combinedItems[index] is Module
                                ? Icons.view_module_outlined
                                : Icons.quiz_rounded,
                          ),
                          onTap: () {
                            courseCreatingBloc.add(NavigateToModule(buildContext: context, moduleType: combinedItems[index]));                          
                          },
                          title: Text(
                            combinedItems[index].title,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                          ),
                          trailing: PopupMenuButton<String>(
                            color: Colors.white,
                            icon: const Icon(Icons.more_vert_outlined), 
                            onSelected: (value) {
                              switch (value) {
                                case 'edit':
                                  // Handle edit logic here
                                  break;
                                case 'delete':
                                  // Handle delete logic here
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  ),
                                ),
                              ];
                            },
                          ),
                        )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => const AddModuleButtomSheet(),
                      );
                    },
                    child: const Text('Add module'),
                  ),
                ),
              ],
            );
          } else if (state is CourseCreatingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
