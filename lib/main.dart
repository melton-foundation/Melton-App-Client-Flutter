import 'dart:async';


import 'package:melton_app/Notification/NotificationBuilder.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:melton_app/util/token_handler.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/screens/splash.dart';
import 'package:melton_app/util/service_locator.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

// todo optimize imports in all files

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  var sentry = GetIt.instance.get<SentryService>().getSentryLogger();
  runZonedGuarded(
        () => runApp(MyApp()),
        (error, stackTrace) async {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void backgroundFetchHeadlessTask(String taskId) async {
  print('[BackgroundFetch] Headless event received.' + taskId);
  callbackNotificationChecker(taskId);
  BackgroundFetch.finish(taskId);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}



class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

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

  Future<void> initPlatformState() async {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15, //todo increase in prod
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY
      ), (String taskId) {callbackNotificationChecker(taskId);}).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });

    if (!mounted) return;
  }
}

void callbackNotificationChecker(String taskId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (!preferences.containsKey(TokenHandler.APP_TOKEN_KEY)) {
    print("token not found, finishing background task");
    BackgroundFetch.finish(taskId);
  }
  String appToken = preferences.getString(TokenHandler.APP_TOKEN_KEY);
  PostsNotificationModel postsNotificationModel = await ApiService().getRecentPostForNotification(appToken);
  NotificationBuilder builder = NotificationBuilder();
  builder.init();
  builder.handleNotification(postsNotificationModel); //todo await needed?
  BackgroundFetch.finish(taskId);
}
