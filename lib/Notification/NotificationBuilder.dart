import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> getPreviewImagePath(String previewImage) async {
  String imagePath;
  if(previewImage != null && previewImage.length != 0) {
    imagePath = await _downloadAndSaveFile(previewImage, 'notification.jpg');
  }
  return imagePath;
}

void showNotification(title, body, notificationsPlugin, {String previewImage}) async {
  print('showNotification');
  var android;
  var iOS;
  if (previewImage != null) {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(previewImage),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: false,
    );
    android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Simple Notification',
      priority: Priority.high, importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      styleInformation: bigPictureStyleInformation,
    );
    iOS = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(previewImage)]);
  } else {
    android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Simple Notification',
      priority: Priority.high, importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    iOS = IOSNotificationDetails();
  }

  var platform = NotificationDetails(android:android, iOS:iOS);
  await notificationsPlugin.show(
      0, '$title', '$body', platform,
      payload: 'PAYLOAD: $title');
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory.path}/$fileName';
  http.Response response = await http.get(url);
  File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

class NotificationBuilder {
  FlutterLocalNotificationsPlugin _notificationsPlugin;

  void init() {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      print('in NB, platform is ios');
      _requestIOSPermissions();
    }
  }

  _requestIOSPermissions() {
    _notificationsPlugin
      .resolvePlatformSpecificImplementation
      <IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void handleNotification(PostsNotificationModel notificationModel) async {
    print('handleNotification');
    String previewImagePath;
    if (notificationModel.showNotification) {
      previewImagePath = await getPreviewImagePath(notificationModel.previewImage);
      var android = AndroidInitializationSettings('@mipmap/ic_launcher');
      var iOS = IOSInitializationSettings();
      var initSettings = InitializationSettings(android:android, iOS:iOS);
      _notificationsPlugin.initialize(initSettings);
      showNotification(notificationModel.title,
          notificationModel.description, _notificationsPlugin, previewImage: previewImagePath);
    } else {
      print("fetch : ApiService failed");
    }
  }

}
