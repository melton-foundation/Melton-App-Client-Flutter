import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:melton_app/Notification/NotificationBuilder.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:melton_app/sentry/SentryService.dart';
import 'package:melton_app/util/persistent_storage.dart';
import 'package:melton_app/util/token_handler.dart';

//import 'package:flutter/cupertino.dart';
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

  PersistentStorage storage = GetIt.I.get<PersistentStorage>();
  await storage.saveStringToStorage(
      TokenHandler.APP_TOKEN_KEY, '7fb877e5153f1695899bac29b6380e96dceeb7ec');
  String tk = await storage.readStringFromStorage(TokenHandler.APP_TOKEN_KEY);

  print("Faking it XD");
  print(tk);

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
            minimumFetchInterval: 1380, // 23 hours
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) {
      callbackNotificationChecker(taskId);
    }).then((int status) {}).catchError((e) {});

    if (!mounted) return;
  }
}

void callbackNotificationChecker(String taskId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (!preferences.containsKey(TokenHandler.APP_TOKEN_KEY)) {
    BackgroundFetch.finish(taskId);
  }
  String appToken = preferences.getString(TokenHandler.APP_TOKEN_KEY);
  PostsNotificationModel postsNotificationModel =
      await ApiService().getRecentPostForNotification(appToken);
  NotificationBuilder builder = NotificationBuilder();
  builder.init();
  await builder.handleNotification(postsNotificationModel);
  BackgroundFetch.finish(taskId);
}
