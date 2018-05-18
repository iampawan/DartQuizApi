import 'package:quiz_api/model/question.dart';
import 'package:quiz_api/quiz_api.dart';

class QuestionController extends HTTPController {
  var questions = ["Who are you?", "How are you Pawan?"];

  @httpGet
  Future<Response> getQuestions(
      {@HTTPQuery("contains") String containsString}) async {
    var questionQuery = new Query<Question>()
      ..join(object: (question) => question.answer);

    if (containsString != null) {
      questionQuery.where.description = whereContainsString(containsString);
    }
    List<Question> databaseQuestions = await questionQuery.fetch();

    return new Response.ok(databaseQuestions);
  }

  @httpGet
  Future<Response> getQuestionAtIndex(@HTTPPath("index") int index) async {
    var questionQuery = new Query<Question>()
      ..join(object: (question) => question.answer)
      ..where.index = whereEqualTo(index);

    var question = await questionQuery.fetchOne();

    if (question == null) {
      return new Response.notFound();
    }
    return new Response.ok(question);
  }
}
