import 'package:flutter/material.dart';

class PostsNotificationModel {
  bool showNotification;
  String title;
  String description;
  String previewImage;

  PostsNotificationModel(
      {@required this.showNotification,
      this.title,
      this.description,
      this.previewImage});
}
