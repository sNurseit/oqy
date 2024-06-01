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
                Text('Quizes and modules'),
                Expanded(
                  child: ListView.builder(
                    itemCount: combinedItems.length,
                    itemBuilder: (context, index) {
                      final item = combinedItems[index];
                      final key = GlobalKey();
                      return GestureDetector(
                        key: key,
                        onLongPress: () {
                          final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(Offset.zero);
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              position.dx+20,
                              position.dy+20,
                              position.dx + renderBox.size.width,
                              position.dy + renderBox.size.height,
                            ),
                            items: const [
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ),
                            ],
                          ).then((value) {
                            if (value == 'edit') {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => AddModuleButtomSheet(
                                  stepItem: item,
                                ),
                              );
                            } else if (value == 'delete') {
                              // Handle delete logic here
                            }
                          });
                        },
                        child: ListTile(
                          leading: Icon(
                            item is Module ? Icons.view_module_outlined : Icons.quiz_rounded,
                          ),
                          onTap: () {
                            courseCreatingBloc.add(NavigateToModule(
                              buildContext: context,
                              moduleType: item,
                            ));
                          },
                          title: Text(
                            item.title,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                          ),
                        ),
                      );
                    },
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
