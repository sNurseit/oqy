class ApiConstants{
  static const String API="http://10.0.2.2:8000/gateway";
  static const String AUTH='http://10.0.2.2:8000/gateway/auth/token';
  static const String register='http://10.0.2.2:8000/gateway/auth/register';

  static const String GET_ALL_COURSES='http://10.0.2.2:8000/gateway/core/api/courses/search';
  static const String course ='http://10.0.2.2:8000/gateway/core/api/courses';
  static const String search='http://10.0.2.2:8000/gateway/core/api/courses/search';
  static const String myTraining='http://10.0.2.2:8000/gateway/core/api/courses/my-training';

  static const String buyCourse='http://10.0.2.2:8000/gateway/core/api/enrollment';
  static const String myProfile='http://10.0.2.2:8000/gateway/core/api/profile';
  static const String myCreated= 'http://10.0.2.2:8000/gateway/core/api/courses/my-created';

  static const String courseCategories = 'http://10.0.2.2:8000/gateway/core/api/course-category/all';
  static const String reviews = 'http://10.0.2.2:8000/gateway/core/api/reviews/course-id';
}