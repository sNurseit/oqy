import 'package:oqy/domain/entity/answer.dart';

abstract class AnswerService{
  Future<Answer> findById(int id);
  Future<Answer> update(Answer answer);
  Future<void> deleteById(int id);
  Future<Answer> create(Answer answer);
}