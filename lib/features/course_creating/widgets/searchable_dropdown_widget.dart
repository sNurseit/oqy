import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course_category.dart';


class CategoryDropDown extends StatelessWidget {
  final List<CourseCategory> categories;
  final Function(CourseCategory?) onCategorySelected;

  const CategoryDropDown({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CourseCategory>(
      value: null,
      onChanged: (selected) {
        onCategorySelected(selected);
      },
      items: categories
          .map(
            (category) => DropdownMenuItem<CourseCategory>(
              value: category,
              child: Text(category.nameEn!),
            ),
          )
          .toList(),
    );
  }
}

