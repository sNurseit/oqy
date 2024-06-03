import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/module.dart';

class CourseModelList extends StatelessWidget {

  final List<StepItem>? stepItems;
  const CourseModelList({required this.stepItems, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final modules =  stepItems != null ? List.generate(
      stepItems!.length,
      (int index) =>Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child:  ExpansionTile(
          leading: stepItems![index] is Module ? const Icon(Icons.view_module_rounded): const Icon(Icons.quiz_outlined) ,
          childrenPadding: EdgeInsets.zero,
          title: Text(stepItems![index].title, maxLines: 2, style: theme.textTheme.bodySmall,
          ),
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                stepItems![index].description != null ? stepItems![index].description! : '', 
                style: theme.textTheme.displaySmall,
              ),
            ),
          ],
        ),
      )
    ): <Widget>[
      Center(child: Text('No Modules')),
    ];

    return Column(
      children:  modules.map((module) {
        return module;
      }).toList()

    );
  }
}