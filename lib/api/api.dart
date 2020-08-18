import 'package:http/http.dart' as http;
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/models/StoreModel.dart';

import 'dart:async';
import 'dart:convert';

// todo make singleton
class ApiService {

  static const apiUrl = "https://meltonapp.com/api/";
  static const users =  "users";
  static const profile = "profile";
  static const store_shop = "store";
  static const store_buy = "buy";

  //todo handle token
  static String token = "Token " + "3a9a52020a37e9ed4768aba67736c8209f8867b0";
  static Map<String, String> authHeader = {"Authorization": token};

  Future<List<UserModel>> getUsers() async {
    http.Response response = await http.get(apiUrl + users, headers: authHeader);
    bool result = handleError(response);
    if (result) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<UserModel> users;
      for (int i = 0; i < jsonResponse.length; i++) {
        UserModel user =  UserModel.fromJson(jsonResponse[i]);
        users.add(user);
      }
      return users;
    } else {
      //todo show error msg
      print("request failed");
    }
  }

  Future<ProfileModel> getProfile() async {
    http.Response response = await http.get(apiUrl + profile, headers: authHeader);
    bool result = handleError(response);
    if (result) {
      return ProfileModel.fromJson(json.decode(response.body));
    }
    else {
      //todo show error msg
      print("request failed");
    }
  }

  Future<List<StoreModel>> getStoreItems() async {
    http.Response response = await http.get(apiUrl + store_shop, headers: authHeader);
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<StoreModel> items = new List<StoreModel>();
      for (int i = 0; i < jsonResponse.length; i++) {
        StoreModel item =  StoreModel.fromJson(jsonResponse[i]);
        items.add(item);
      }
      return items;
    } else {
      //todo show error msg snackbar?
      print("request failed");
    }
  }

  Future<bool> postProfile(ProfileModel profileModel) {
    // todo - need to post all data or only posted data will be updated
  }

  bool handleError(http.Response response) {
    //todo will 201 be returned in profile post?
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      //todo trigger oauth and regenerate token
      return false;
    }  else if (response.statusCode == 403) {
      // not approved by admin yet - show msg
      return false;
    } else if (response.statusCode == 410) {
      // disapproved by admin - show msg
      return false;
    }

  }

}