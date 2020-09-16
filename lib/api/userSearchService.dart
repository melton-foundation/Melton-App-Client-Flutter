import 'dart:async';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:rxdart/rxdart.dart';

class UserSearchService {
  UserSearchService() {
    _results = _searchText
        .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
        .switchMap((searchedName) async* {
      print('searching: $searchedName');
      yield await ApiService().getUserModelByName(searchedName.trim());
    });
  }

  // Input stream
  final _searchText = BehaviorSubject<String>();
  BehaviorSubject<String> get searchText => _searchText;
  void searchUser(String searchedName) => _searchText.add(searchedName);

  // Output stream
  Stream<List<UserModel>> _results;
  Stream<List<UserModel>> get results => _results;

  void dispose() {
    _searchText.close();
  }
}