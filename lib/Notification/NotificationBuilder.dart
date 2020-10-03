import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    PostsNotificationModel postsNotificationModel = await ApiService().getRecentPostForNotification(inputData);
    if(postsNotificationModel.showNotification){
      FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
      var android = AndroidInitializationSettings('@mipmap/ic_launcher');  // Different icon is shown in notification
      var iOS = IOSInitializationSettings();
      var initSettings = InitializationSettings(android, iOS);
      notificationsPlugin.initialize(initSettings);
      showNotification(postsNotificationModel.title,
          postsNotificationModel.description, notificationsPlugin, previewImage: postsNotificationModel.previewImage);
    } else{
      print("fetch : ApiService failed");
    }
    return Future.value(true);
  });
}

void showNotification(title, body, notificationsPlugin, {String previewImage}) async {
  if(previewImage != null ) print("preview Image : "+ previewImage);  // Currently image is not used,
  var android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Notification',
      priority: Priority.High, importance: Importance.Max, largeIcon: DrawableResourceAndroidBitmap('app_icon'));
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await notificationsPlugin.show(
      0, '$title', '$body', platform,
      payload: 'PAYLOAD: $title');
}

class NotificationBuilder {
  static const String WORKMANAGER_ID = "1";
  static const String WORKMANAGER_NAME = "FetchAndNotifyRecentPosts";
  static const int WORKMANAGER_DURATION_IN_MINUTES = 15;
  static const int WORKMANAGER_DELAY_IN_SECONDS = 15;

  initWorkmanager() async{
    WidgetsFlutterBinding.ensureInitialized();

    Map<String, dynamic> inputData = new Map();
    inputData.addAll(ApiService().getAuthHeader());
    inputData.addAll(ApiService().getUrl());

    await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager.registerPeriodicTask(
      WORKMANAGER_ID, WORKMANAGER_NAME,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      inputData: inputData,
      frequency: Duration(minutes: WORKMANAGER_DURATION_IN_MINUTES),
      initialDelay: Duration(seconds: WORKMANAGER_DELAY_IN_SECONDS),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

}
