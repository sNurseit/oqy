import 'package:oqy/domain/entity/review.dart';

abstract class ReviewService{
  Future<List<Review>> findReviewsByCourseId(int id);
  Future<List<Review>> create(Review review);
}