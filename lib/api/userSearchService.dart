import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:melton_app/screens/DirectoryComponents/UserFilterAvailableOptions.dart';

class UserSearchService {
  Set<dynamic> filteredCampuses = Set<dynamic>();
  Set<dynamic> filteredBatchYear = Set<dynamic>();
  Set<dynamic> filteredSDGs = Set<dynamic>();

  List<UserModel> allUsers;
  UserFilterAvailableOptions userFilterAvailableOptions = UserFilterAvailableOptions();
  UserSearchService() {
    _results = _searchText
        .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
        .switchMap((searchedName) async* {
      print('searching: $searchedName');

      if (searchedName.trim().length == 0) {
        allUsers = await ApiService().getUsers();
        allUsers.shuffle();
        updateFilters(allUsers);
        yield allUsers;
      } else {
        allUsers = await ApiService().getUserModelByName(searchedName.trim());
        updateFilters(allUsers);
        yield allUsers;
      }
      _searchedString.add(searchedName);
      _filters.add(userFilterAvailableOptions);
    });
  }

  // Input stream
  final _searchText = BehaviorSubject<String>();
  void searchUser(String searchedName) => _searchText.add(searchedName);

  // Output stream
  Stream<List<UserModel>> _results;
  Stream<List<UserModel>> get results => _results;

  //Filters
  StreamController<UserFilterAvailableOptions> _filters = StreamController<UserFilterAvailableOptions>();
  Stream<UserFilterAvailableOptions> get filters => _filters.stream;

  StreamController<String> _searchedString = StreamController<String>();
  Stream<String> get searchedString => _searchedString.stream;

  void updateFilters(List<UserModel> users){
    userFilterAvailableOptions.clearFilters();
    Set<int> batch = Set<int>();
    for (UserModel user in users) {
      if(!userFilterAvailableOptions.campusFilter.containsValue(user.campus)){
        userFilterAvailableOptions.campusFilter.addAll({userFilterAvailableOptions.campusFilter.length: user.campus});
      }
      if(!userFilterAvailableOptions.batchYear.containsValue(user.batch)){
        userFilterAvailableOptions.batchYear.addAll({userFilterAvailableOptions.batchYear.length: user.batch});
      }
      /*if(!userFilterAvailableOptions.SDG.containsValue(user.SDGs)){
        userFilterAvailableOptions.SDG.addAll({userFilterAvailableOptions.SDG.length: user.SDGs.toString()});
      }*/
    }
  }

  void dispose() {
    _searchText.close();
  }
}