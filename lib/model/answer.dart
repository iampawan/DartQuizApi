import 'package:quiz_api/model/question.dart';
import 'package:quiz_api/quiz_api.dart';

class Answer extends ManagedObject<_Answer> implements _Answer {}

class _Answer {
  @managedPrimaryKey
  int id;
  String description;

  @ManagedRelationship(#answer,
      onDelete: ManagedRelationshipDeleteRule.cascade, isRequired: true)
  Question question;
}
