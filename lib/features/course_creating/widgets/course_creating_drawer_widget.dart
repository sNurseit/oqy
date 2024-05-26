import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc.dart';
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
            final modules = state.courseModules;
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
                      final ModuleType item = modules.removeAt(oldIndex);
                      modules.insert(newIndex, item);
                      courseCreatingBloc.add(ChangeModuleStep(moduleTypes: modules));
                    },
                    children: [
                      for (int index = 0; index < modules.length; index++)
                        ListTile(
                          key: ValueKey(modules[index].uuid),
                          leading: Icon(
                            modules[index].type == "module"
                                ? Icons.view_module_outlined
                                : Icons.quiz_rounded,
                          ),
                          onTap: () {
                            // Ваш код для обработки нажатия на ListTile
                          },
                          title: Text(modules[index].title),
                          trailing: PopupMenuButton<String>(
                            color: Colors.white,
                            icon: const Icon(Icons.more_horiz_outlined), 
                            onSelected: (value) {
                              switch (value) {
                                case 'edit':
                                  
                                  break;
                                case 'delete':
                                  
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


class ModulesScreen extends StatelessWidget {
  final int index;
  const ModulesScreen({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules'),
      ),
      body: const Center(
        child: Text('Modules Screen'),
      ),
      endDrawer: CourseCreatingDrawerWidget(
        index: index,
      ),
    );
  }
}
