import 'dart:async';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:rxdart/rxdart.dart';

enum APIError { rateLimitExceeded }

class UserSearchService {
  UserSearchService() {
    _results = _searchText
        .debounce((_) => TimerStream(true, Duration(milliseconds: 250)))
        .switchMap((searchedName) async* {
      print('searching: $searchedName');
      if(searchedName == ""){
        yield await ApiService().getUsers();
      }
      else{
        yield await ApiService().getUserModelByName(searchedName);
      }
    });
  }

  // Input stream
  final _searchText = BehaviorSubject<String>();
  void searchUser(String searchedName) => _searchText.add(searchedName);

  // Output stream
  Stream<List<UserModel>> _results;
  Stream<List<UserModel>> get results => _results;

  void dispose() {
    _searchText.close();
  }
}