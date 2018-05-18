import 'package:quiz_api/model/answer.dart';
import 'package:quiz_api/quiz_api.dart';

class Question extends ManagedObject<_Question> implements _Question {}

class _Question {
  @managedPrimaryKey
  int index;
  String description;

  Answer answer;
}
