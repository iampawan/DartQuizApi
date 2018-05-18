import 'harness/app.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();
  });

  tearDownAll(() async {
    await app.stop();
  });

  test("add two numbers", () {
    expect(1 + 1, equals(2));
  });
}
