import 'package:aqueduct/test.dart';
import 'package:quiz_api/quiz_api.dart';

export 'package:aqueduct/aqueduct.dart';
export 'package:aqueduct/test.dart';
export 'package:quiz_api/quiz_api.dart';
export 'package:test/test.dart';

/// A testing harness for quiz_api.
///
/// Use instances of this class to start/stop the test quiz_api server. Use [client] to execute
/// requests against the test server.  This instance will use configuration values
/// from config.src.yaml.
class TestApplication {
  Application<QuizApiSink> application;
  QuizApiSink get sink => application.mainIsolateSink;
  TestClient client;

  /// Starts running this test harness.
  ///
  /// This method will start an [Application] with [QuizApiSink]. Invoke this method
  /// in setUpAll (or setUp, depending on your need).
  ///
  /// You must call [stop] on this instance when tearing down your tests.
  Future start() async {
    RequestController.letUncaughtExceptionsEscape = true;
    application = new Application<QuizApiSink>();
    application.configuration.port = 0;
    application.configuration.configurationFilePath = "config.src.yaml";

    await application.start(runOnMainIsolate: true);

    await createDatabaseSchema(sink.context);

    client = new TestClient(application);
  }

  /// Stops running this application harness.
  ///
  /// This method must be invoked in tearDownAll or tearDown to free up operating system
  /// resources.
  Future stop() async {
    await application?.stop();
  }

  static Future createDatabaseSchema(ManagedContext context) async {
    var builder = new SchemaBuilder.toSchema(
        context.persistentStore, new Schema.fromDataModel(context.dataModel),
        isTemporary: true);

    for (var cmd in builder.commands) {
      await context.persistentStore.execute(cmd);
    }
  }
}
