import 'package:flutter/material.dart';
import 'package:oqy/features/training/model/my_training_model.dart';
import 'package:provider/provider.dart';

class CourseModules extends StatelessWidget {
  CourseModules({ super.key});
  @override
  Widget build(BuildContext context) {
    final modules = context.watch<MyTrainingModel>().course?.modules;
    final theme = Theme.of(context);
    return modules == null? const SizedBox(height: 50) 
    :ListView.builder(
          itemCount: modules.length,
          itemBuilder: (context, index) {
            return modules[index].materials != null ? ExpansionTile(
              title: Text(modules[index].title, style: theme.textTheme.displayMedium,),
              children: modules[index].materials.map((material) {
                print(material.title);
                return ListTile(
                  title: Text(material.title, style: theme.textTheme.displayMedium,),
                );
              }).toList(),
            )
            : ListTile(
              title: Text(modules[index].title),
            );
          },
        );
    }
}