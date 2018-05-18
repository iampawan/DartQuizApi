import 'dart:io' show Platform;

import 'package:quiz_api/quiz_api.dart';

Future main() async {
  var app = new Application<QuizApiSink>()
    ..configuration.configurationFilePath = "config.yaml"
    ..configuration.port = 8000;

  await app.start(numberOfInstances: Platform.numberOfProcessors);

  print("Application started on port: ${app.configuration.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
