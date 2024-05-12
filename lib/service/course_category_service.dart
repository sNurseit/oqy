import 'package:oqy/domain/entity/course_category.dart';

abstract class CourseCategoryService {
 Future<List<CourseCategory>> getAllCategories();
}