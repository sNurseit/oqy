

import 'package:oqy/domain/entity/question.dart';

abstract class QuestionService{
  Future<List<Question>> findAllByQuizId(int quizId);
  Future<Question> findById(int id);
  Future<Question> update(Question module);
  Future<void> deleteById(int id);
  Future<Question> create(Question module);
}