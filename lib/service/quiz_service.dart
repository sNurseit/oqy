import 'package:oqy/domain/dto/answered_dto.dart';
import 'package:oqy/domain/entity/quiz.dart';

abstract class QuizService {
  Future<Quiz> findById(int id);
  Future<Quiz> update(Quiz quiz);
  Future<void> deleteById(int id);
  Future<Quiz> create(Quiz quiz);
  Future<List<Quiz>> findAllByCourseId(int courseId);
  Future<int> checkQuiz(int quizId, List<AnsweredDto> answers);
}