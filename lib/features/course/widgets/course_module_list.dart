import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/module_item.dart';
import 'package:oqy/features/course/model/course_model.dart';


class CourseModelList extends StatelessWidget {
  const CourseModelList({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = CourseProvider.watch(context).model.modules;
    final provider = CourseProvider.watch(context).model;
    final theme = Theme.of(context);
    return ExpansionPanelList(
          dividerColor: theme.secondaryHeaderColor,
          materialGapSize: 1,
          expansionCallback: (int index, bool isExpanded) {
            provider.expand(index,);
          },
          children: modules.map<ExpansionPanel>((ModuleItem item) {
            return ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.module.title, style: theme.textTheme.displayMedium,),
                );
              },
              body: ListTile(
                  subtitle:Text(item.module.description, style: theme.textTheme.displaySmall,),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        );
  }
}