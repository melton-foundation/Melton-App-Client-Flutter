import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    PostsNotificationModel postsNotificationModel = await ApiService().getRecentPostForNotification(inputData);
    String previewImagePath;
    if(postsNotificationModel.showNotification){
      previewImagePath = await getPreviewImagePath(postsNotificationModel.previewImage);
      FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();
        var android = AndroidInitializationSettings('@mipmap/ic_launcher');  // Different icon is shown in notification
        var iOS = IOSInitializationSettings();
        var initSettings = InitializationSettings(android, iOS);
        notificationsPlugin.initialize(initSettings);
        showNotification(postsNotificationModel.title,
            postsNotificationModel.description, notificationsPlugin, previewImage: previewImagePath);
    } else{
      print("fetch : ApiService failed");
    }
    return Future.value(true);
  });
}

Future<String> getPreviewImagePath(String previewImage) async {
  String imagePath;
  if(previewImage != null && previewImage.length != 0) {
    imagePath = await _downloadAndSaveFile(previewImage, 'notification.jpg');
  }
  return imagePath;
}

void showNotification(title, body, notificationsPlugin, {String previewImage}) async {
  var android;
  var iOS;
  if(previewImage != null ){
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(previewImage),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: false,
    );
    android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Simple Notification',
      priority: Priority.High, importance: Importance.Max,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      styleInformation: bigPictureStyleInformation,
    );
    iOS = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(previewImage)]);
  } else {
    android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Simple Notification',
      priority: Priority.High, importance: Importance.Max,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    iOS = IOSNotificationDetails();
  }

  var platform = NotificationDetails(android, iOS);
  await notificationsPlugin.show(
      0, '$title', '$body', platform,
      payload: 'PAYLOAD: $title');
}

_downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http.get(url);
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
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
