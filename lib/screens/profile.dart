import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/PostsNotificationModel.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/screens/components/UserProfileInformation.dart';
import 'package:melton_app/screens/profile_edit.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    PostsNotificationModel postsNotificationModel = await ApiService().getRecentPostForNotification(inputData);
    if(postsNotificationModel.showNotification){
      FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
      var android = AndroidInitializationSettings('@mipmap/ic_launcher');
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
  if(previewImage != null ) print("preview Image : "+ previewImage);
  var android = AndroidNotificationDetails(
      'MeltonApp', 'Melton App Notification', 'Recent Post Notification',
      priority: Priority.High, importance: Importance.Max, largeIcon: DrawableResourceAndroidBitmap('app_icon'));
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await notificationsPlugin.show(
      0, '$title', '$body', platform,
      payload: 'PAYLOAD: $title');
}


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamController<ProfileModel> _streamController;
  ProfileModel _loaded;
  bool isProfileUpdated = false;
  static const String WORKMANAGER_ID = "2";
  static const String WORKMANAGER_NAME = "FetchAndNotifyRecentPosts";
  static const int WORKMANAGER_DURATION_IN_MINUTES = 15;
  static const int WORKMANAGER_DELAY_IN_SECONDS = 15;

  final Widget empty = Container(width: 0.0, height: 0.0);


  @override
  void initState() {
    _streamController = StreamController<ProfileModel>();
    loadProfile();
    super.initState();
    initWorkmanager();
     // NotificationBuilder().initWorkmanager();
  }
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
  loadProfile() async {
    ApiService().getProfile().then((res) async {
      _streamController.add(res);
    });
  }

  Future<void> _handleRefresh() async {
    await loadProfile();
    await Future.delayed(Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Refreshed profile!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ProfileModel>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            //todo use connection state != done
            // todo also add connection.none for "no internet" error in all futures
            if (snapshot.hasData) {
              _loaded = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: buildUserDetailsListView(snapshot.data),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () async {
            _loaded == null ? null :
            isProfileUpdated = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProfileEdit(initialModel: _loaded, profileRefreshFunction: loadProfile)));
            if (isProfileUpdated != null && isProfileUpdated) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Saved profile."),
              ));
              loadProfile();
            }
          },
        )
    );
  }

  ListView buildUserDetailsListView(ProfileModel data) {
    return ListView(
      children: getUserDetails(
        isProfileModel: true,
        picture: data.picture,
        name: data.name,
        isJuniorFellow: data.isJuniorFellow,
        points: data.points,
        socialMediaAccounts: data.socialMediaAccounts,
        bio: data.bio,
        work: data.work,
        SDGs: data.SDGs,
        phoneNumber: data.phoneNumber.phoneNumber,
        countryCode: data.phoneNumber.countryCode,
        campus: data.campus,
        batch: data.batch,
        city: data.city,
        email: data.email,
      ),
    );
  }
}
