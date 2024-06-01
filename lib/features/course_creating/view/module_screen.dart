import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/features/course_creating/bloc/module_edit_bloc/module_edit_bloc.dart';
import 'package:oqy/features/course_creating/widgets/add_material_bottom_sheet.dart';
import 'package:oqy/widgets/custom_list_tile.dart';
import 'package:oqy/widgets/error_loading_widget.dart';

@RoutePage()
class ModuleScreen extends StatefulWidget {
  final int moduleId;
  const ModuleScreen({super.key, required this.moduleId});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ModuleEditBloc>().add(LoadModuleEdit(moduleId: widget.moduleId));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ModuleEditBloc>();
    final theme = Theme.of(context);

    return BlocBuilder<ModuleEditBloc, ModuleEditState>(
      builder: (context, state) {
        if (state is ModuleEditLoaded) {
          final module = state.module;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                module.title,
                style: theme.textTheme.displayMedium,
                maxLines: 2,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => AddMaterialBottomSheet(
                        material: MaterialEntity(moduleId: widget.moduleId),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text('Description'),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          module.description ?? '',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Materials'),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: module.materials?.length ?? 0,
                        itemBuilder: (context, index) {
                          final material = module.materials![index];
                          return Column(
                            children: [
                              Slidable(
                                key: Key('${material.step}'),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => AddMaterialBottomSheet(material: material),
                                        );
                                      },
                                      backgroundColor: const Color.fromARGB(255, 27, 211, 58),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        bloc.add(DeleteMaterial(materialId: material.id!));
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  color: theme.cardColor,
                                  child: CustomListTile(
                                    icon: material.type == 'text' ? Icons.text_fields_rounded : Icons.play_circle_fill_rounded,
                                    title: material.title!,
                                    trailing: true,
                                    onTap: () {
                                      bloc.add(NavigateToMyMaterial(context: context, materialId: material.id!));
                                    },
                                  ),
                                ),
                              ),
                              if (index < module.materials!.length - 1)
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 1.0,
                                  height: 0,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is CourseCreatingError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: ErrorLoadingWidget(
                onTryAgain: () {
                  // Implement your try again logic
                },
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
