class ApiConstants{
  static const String API="http://10.0.2.2:8000/gateway";

  static const String auth='$API/auth';

  static const String GET_ALL_COURSES='$API/core/api/courses/search';
  static const String course ='$API/core/api/courses';
  static const String search='$API/core/api/courses/search';
  static const String myTraining='$API/core/api/courses/my-training';

  static const String buyCourse='$API/core/api/enrollment';
  static const String myProfile='$API/core/api/profile';
  static const String myCreated= '$API/core/api/courses/my-created';

  static const String courseCategories = '$API/core/api/course-category/all';
  static const String reviews = '$API/core/api/reviews';

  static const String getModule = '$API/core/api/modules/module';
  static const String module = '$API/core/api/modules';
  
  static const String quiz = '$API/core/api/quizzes';  

  static const String material = '$API/core/api/materials';

  static const String question = '$API/core/api/questions';

  static const String lesson = '$API/core/api/lessons';

  static const int appID = 268806430;
  static const String serverSecret = 'eeea02b9bb14a5d5558b44aabb96205c';
  static const String file = '$API/file/test';
}