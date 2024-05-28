import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';
import 'package:oqy/features/course_creating/bloc/module_edit_bloc/module_edit_bloc.dart';
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
    context
        .read<ModuleEditBloc>()
        .add(LoadModuleEdit(moduleId: widget.moduleId));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ModuleEditBloc>();
    final theme = Theme.of(context);

    return BlocBuilder<ModuleEditBloc, ModuleEditState>(
      builder: (context, state) {
        if(state is ModuleEditLoaded){
          final module = state.module;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed:()=> {},
              ),
              title:  Text(
                module.title, 
                style: theme.textTheme.displayMedium,
                maxLines: 2,
              ),
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.add))
              ],
            ),
            body: module.materials !=null &&  module.materials!.isNotEmpty ?
              ListView(
               children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Description'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(module.description!, 
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Materials'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Column(
                          children: [
                              for (int index = 0; index < module.materials!.length; index++) ...[
                                Slidable(
                                  key: Key('${module.materials![index].step}'),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children:  [
                                      SlidableAction(
                                        onPressed: (BuildContext context) =>{},
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    color: theme.cardColor,
                                    child: CustomListTile(
                                      icon: module.materials![index].type == 'text'? Icons.text_fields_rounded : Icons.play_circle_fill_rounded,
                                      title: module.materials![index].title!,
                                      trailing: true,
                                    onTap: () {
                                      //courseCreatingBloc.add(NavigateToMaterial(buildContext: context, materialStep: module.materials![index].step!, moduleStep: widget.moduleId));
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
                          ],
                        ),
                      ),
                    ),
                  ],
              )
            : const Center(child: Text('No materials'),),
          );
        } else if(state is CourseCreatingError){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: ErrorLoadingWidget(
                onTryAgain: ()=> {}//courseCreatingBloc.add(PopNavigate(buildContext: context)),
              ),
            ),
          );
        }
        return  Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}
