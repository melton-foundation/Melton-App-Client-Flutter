import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:melton_app/models/PostsNotificationModel.dart';

import 'package:melton_app/util/token_handler.dart';

import 'package:melton_app/models/PostModel.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/models/StoreModel.dart';
import 'package:melton_app/models/UserRegisterModel.dart';
import 'package:melton_app/models/UserRegisterResponseModel.dart';
import 'package:melton_app/models/UserRegistrationStatusModel.dart';


class ApiService {

  static const apiUrl = "https://meltonapp.com/api/";
  static const users =  "users/";
  static const profile = "profile/";
  static const store_shop = "store/";
  static const store_buy = "buy/";
  static const post_preview = "posts/";
  static const search = "?search=";
  static const register = "register/";
  static const registration_status = "registration-status/";

  String get token => GetIt.instance.get<TokenHandler>().getToken();

  Map<String, String> getAuthHeader() {
    return {"Authorization": token};
  }

  Map<String, String> getUrl(){
    return {"url": apiUrl};
  }

  Map<String, String> getAuthAndJsonContentHeader() {
    return {
      "Authorization": token,
      "Content-Type": "application/json",
    };
  }

  static Map<String, String> contentHeader = {
    "Content-Type": "application/json"
  };

  Future<UserRegistrationStatusModel> getAppToken(String email, String oauthToken,
      {String oauthProvider="GOOGLE"}) async {
    Map<String, String> jsonBodyMap = {
      "email": email,
      "token": oauthToken,
      "authProvider": oauthProvider
    };
    http.Response response = await http.post(apiUrl + "login/",
    headers: contentHeader,
    body: json.encode(jsonBodyMap)
    );
    if (response.statusCode == 200) {
      return UserRegistrationStatusModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode == 403) {
      return UserRegistrationStatusModel(isApproved: false, appToken: null);
    } else {
      return null;
    }
  }

  Future<bool> checkNetworkConnectivity() async {
    try {
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //add support for no internet error screen?
  // todo IMP - handle 403 case for all api calls - redirect to error screen
  Future<bool> verifyAppTokenValid() async {
    http.Response response = await http.get(apiUrl + "profile/", headers: getAuthHeader());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<UserModel>> getUsers() async {
    http.Response response = await http.get(apiUrl + users, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<UserModel> users = new List<UserModel>();
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

  Future<UserModel> getUserModelById(int id) async{
    http.Response response = await http.get(apiUrl + users + id.toString(), headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      return UserModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    else {
      //todo show error msg
      print("request failed");
    }
    return UserModel();
  }

  Future<List<UserModel>> getUserModelByName(String name) async{
    http.Response response = await http.get(apiUrl + users + search + name, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<UserModel> users = new List<UserModel>();
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
    http.Response response = await http.get(apiUrl + profile, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      return ProfileModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    else {
      //todo show error msg
      print("request failed");
    }
  }

  Future<UserRegistrationStatusModel> getRegistrationStatus() async {
    http.Response response = await http.get(apiUrl + registration_status, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      return UserRegistrationStatusModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    else {
      //todo show error msg
      print("request failed");
    }
  }

  Future<List<StoreModel>> getStoreItems() async {
    http.Response response = await http.get(apiUrl + store_shop, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
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

  Future<StoreItemBuy> buyStoreItem(int itemId) async {
    http.Response response = await http.post(apiUrl + store_buy,
        headers: getAuthAndJsonContentHeader(), body: """{"itemId":$itemId}""");
    bool result = handleError(response);
    if (result) {
      return StoreItemBuy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
    }
  }

  //todo convert to sendBottomThree - or not
  // depending on how api sends "last updated" after ordering
  // we need to get 3 latest posts
  Future<List<PostModel>> getPostPreviewList(bool sendTopThree) async {
    http.Response response = await http.get(apiUrl + post_preview, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<PostModel> postPreviewList = new List<PostModel>();
      for (int i = 0; i < jsonResponse.length; i++) {
        PostModel postPreview = PostModel.fromJson(jsonResponse[i]);
        postPreviewList.add(postPreview);
      }
      if (sendTopThree) {
        // return first 3 posts
        return postPreviewList.sublist(0, min(postPreviewList.length, 3));
      } else {
        return postPreviewList;
      }
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
    }
  }

  Future<PostsNotificationModel> getRecentPostForNotification(String appToken) async {
    print('using appToken $appToken');
    http.Response response = await http.get(apiUrl + "posts/", headers: {"Authorization": "Token " + appToken});

    if(response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if(jsonResponse.length > 0){
        DateTime latestDate = DateTime.parse(jsonResponse[0]['created']);
        DateTime now = DateTime.now();
        Duration difference = now.difference(latestDate);
        if(difference.inHours < 24){
          String title = jsonResponse[0]['title'];
          String description = jsonResponse[0]['description'];
          String previewImage = jsonResponse[0]['preview'];
          return new PostsNotificationModel(
              showNotification: true,
              title: title,
              description: description,
              previewImage: previewImage);
        }
      }
    }
    return new PostsNotificationModel(showNotification: false);
  }

  Future<PostModel> getPostById(int postId) async {
    http.Response response = await http.get(apiUrl + post_preview + postId.toString(), headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      PostModel post = PostModel.fromJson(jsonResponse);
      return post;
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
    }
  }

  Future<bool> postProfile(ProfileModel model) async {
    Map<String, dynamic> modelMap = ProfileModel.toJson(model);
    String modelJson = jsonEncode(modelMap);
    print(modelJson);
    http.Response response = await http.post(apiUrl + profile,
        headers: getAuthAndJsonContentHeader(), body: modelJson);
    bool result = handleError(response);
    if (result) {
      return true;
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
    }
  }

  bool handleError(http.Response response) {
    //todo will 201 be returned in profile post?
    if (response.statusCode == 200 || response.statusCode == 201) {
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
    } else {
      // some other error
      return false;
    }

  }

  Future<UserRegisterResponseModel> postRegisterUser(UserRegisterModel model) async {
    Map<String, dynamic> modelMap = model.toJson(model);
    print(json.encode(modelMap));
    http.Response response = await http.post(apiUrl + register,
        headers: getAuthAndJsonContentHeader(), body: json.encode(modelMap));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400) {
      UserRegisterResponseModel responseModel = UserRegisterResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return responseModel;
    }
  }

}