import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:melton_app/util/secrets.dart';
import 'package:melton_app/util/service_locator.dart';
import 'package:sentry/sentry.dart';

final sentry = SentryClient(dsn: Secrets.SENTRY_CLIENT_DSN);

// todo optimize imports in all files

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runZonedGuarded(
        () => runApp(MyApp()),
        (error, stackTrace) async {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Melton Foundation",
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Constants.meltonMaterialBlue,
        textSelectionColor: Constants.meltonBlueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

