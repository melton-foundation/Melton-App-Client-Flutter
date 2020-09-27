import 'dart:async';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:melton_app/screens/DirectoryComponents/UserFilterAvailableOptions.dart';

class UserSearchService {
  static const int CAMPUS_FILTER = 1;
  static const int BATCH_FILTER = 2;
  static const int SDG_FILTER = 3;
  List<UserModel> allUsers;
  FilterOptions filterOptions = FilterOptions();

  UserSearchService() {
    _results = _searchText
        .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
        .switchMap((searchedName) async* {
      if (searchedName == Constants.FILTERS) {
        updateAvailableFilters(allUsers);
        yield applyFiltersOnResponse(allUsers);
      } else if (searchedName.trim().length == 0) {
        allUsers = await ApiService().getUsers();
        allUsers.shuffle();
        updateAvailableFilters(allUsers);
        yield anyFilterSelected() ? applyFiltersOnResponse(allUsers) : allUsers;
      } else {
        allUsers = await ApiService().getUserModelByName(searchedName.trim());
        updateAvailableFilters(allUsers);
        yield anyFilterSelected() ? applyFiltersOnResponse(allUsers) : allUsers;
      }
      _searchedString.add(searchedName);
      _filters.add(filterOptions);
    });
  }

  List<UserModel> applyFiltersOnResponse(List<UserModel> userList) {
    List<UserModel> users = List<UserModel>();
    users =  applyFilter(userList, filterOptions.selectedCampusFilterValues, CAMPUS_FILTER);
    users =  applyFilter(users, filterOptions.selectedBatchYearFilterValues, BATCH_FILTER);
    users =  applyFilter(users, filterOptions.selectedSDGFilterValues, SDG_FILTER);
    return users;
  }

  List<UserModel> applyFilter(List<UserModel> userList,
      List<dynamic> selectedFilterValues, int filter) {
    List<UserModel> users = List<UserModel>();
    if (selectedFilterValues.length == 0) return userList;

    for (UserModel user in userList) {
      if (getValueFromUserForFilter(selectedFilterValues, user, filter)) {
        users.add(user);
      }
    }
    return users;
  }

  void updateAvailableFilters(List<UserModel> users) {
    filterOptions.clearUncheckedFilters();
    Set<dynamic> batchSet = filterOptions.selectedBatchYearFilterValues.toSet();
    for (UserModel user in users) {
      if (!filterOptions.campusFilter.containsValue(user.campus)) {
        filterOptions.campusFilter
            .addAll({filterOptions.campusFilter.length: user.campus});
      }

      batchSet.add(user.batch);

      updateAvailableSDGFilters(user.SDGs.firstSDG);
      updateAvailableSDGFilters(user.SDGs.secondSDG);
      updateAvailableSDGFilters(user.SDGs.thirdSDG);
    }
    List<dynamic> batchList = batchSet.toList();
    batchList.sort();
    batchList.forEach((batch) {
      filterOptions.batchYear.addAll({filterOptions.batchYear.length: batch});
    });
  }

  void updateAvailableSDGFilters(int sdg) {
    if (sdg != null && sdg >= Constants.MIN_SDG_CODE && sdg <= Constants.MAX_SDG_CODE)
    {
      if (!filterOptions.SDG.containsValue(Constants.SDGs[sdg])) {
        filterOptions.SDG.addAll({filterOptions.SDG.length: Constants.SDGs[sdg]});
      }
    }
  }

  bool anyFilterSelected() {
    return (filterOptions.selectedCampusFilterValues.length != 0 ||
        filterOptions.selectedBatchYearFilterValues.length != 0 ||
        filterOptions.selectedSDGFilterValues.length != 0);
  }

  // Input stream
  final _searchText = BehaviorSubject<String>();

  void searchUser(String searchedName) {
    _searchText.add(searchedName);
  }

  // Output stream
  Stream<List<UserModel>> _results;

  Stream<List<UserModel>> get results => _results;

  //Filters
  StreamController<FilterOptions> _filters = StreamController<FilterOptions>();

  Stream<FilterOptions> get filters => _filters.stream;

  StreamController<String> _searchedString = StreamController<String>();

  Stream<String> get searchedString => _searchedString.stream;

  void applyFiltersOnAvailableResults() {
    searchUser(Constants.FILTERS);
  }

  bool getValueFromUserForFilter(
      List<dynamic> selectedFilterValues, UserModel user, int filter) {
    switch (filter) {
      case CAMPUS_FILTER:
        return selectedFilterValues.contains(user.campus);
      case BATCH_FILTER:
        return selectedFilterValues.contains(user.batch);
      case SDG_FILTER:
        return selectedFilterValues.contains(user.SDGs.firstSDG != 0
                ? Constants.SDGs[user.SDGs.firstSDG]
                : "SDG value : 0") ||
            selectedFilterValues.contains(user.SDGs.secondSDG != 0
                ? Constants.SDGs[user.SDGs.secondSDG]
                : "SDG value : 0") ||
            selectedFilterValues.contains(user.SDGs.thirdSDG != 0
                ? Constants.SDGs[user.SDGs.thirdSDG]
                : "SDG value : 0");
    }
    return false;
  }

  void dispose() {
    _searchText.close();
    _filters.close();
    _searchedString.close();
  }
}
