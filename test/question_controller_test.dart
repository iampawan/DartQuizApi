import 'package:quiz_api/model/answer.dart';
import 'package:quiz_api/model/question.dart';

import 'harness/app.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();

    var questions = [
      new Question()
        ..description = "Who are you ?"
        ..answer = (new Answer()..description = "I am Pawan"),
      new Question()
        ..description = "How are you Pawan?"
        ..answer = (new Answer()..description = "I am fine"),
    ];

    await Future.forEach(questions, (Question q) async {
      var query = new Query<Question>()..values = q;

      var insertedQuestions = await query.insert();

      var answerQuery = new Query<Answer>()
        ..values.description = q.answer.description
        ..values.question = insertedQuestions;

      await answerQuery.insert();
      return insertedQuestions;
    });
  });
  tearDownAll(() async {
    await app.stop();
  });

  test("get all questions", () async {
    var request = app.client.request("/questions");
    expectResponse(await request.get(), 200,
        body: allOf([
          hasLength(greaterThan(0)),
          everyElement(partial({
            "description": endsWith("?"),
            "answer": partial({"description": isString})
          }))
        ]));
  });

  test("get all questions which contains", () async {
    var request = app.client.request("/questions?contains=Pawan");
    expectResponse(
      await request.get(),
      200,
    );
  });

  test("return single question test", () async {
    var request = app.client.request("/questions/1");
    expectResponse(await request.get(), 200);
  });
  test("return single question test", () async {
    var request = app.client.request("/questions/100");
    expectResponse(await request.get(), 404);
  });
}
