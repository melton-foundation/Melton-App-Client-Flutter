import 'dart:async';

import 'package:get_it/get_it.dart';

import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/api/api.dart';

class MapSearchService {
  List<UserModel> allUsers;

  MapSearchService() {
    loadUsersAndAddToStream();
  }

  Future<void> loadUsersAndAddToStream() async {
    List<UserModel> allUsers =
        await GetIt.instance.get<ApiService>().getUsers();
    _users.sink.add(allUsers);
  }

  StreamController<List<UserModel>> _users =
      StreamController<List<UserModel>>();

  // only first output is listened to, then subscription is cancelled
  Stream<List<UserModel>> get usersStream => _users.stream;

  void dispose() {
    _users.close();
  }
}
