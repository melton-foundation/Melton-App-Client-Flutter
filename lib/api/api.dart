import 'dart:math';

import 'dart:developer' as dev; //todo remove

import 'package:http/http.dart' as http;
import 'package:melton_app/models/PostModel.dart';
import 'package:melton_app/models/UserModel.dart';
import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/models/StoreModel.dart';

import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:melton_app/util/token_handler.dart';

class ApiService {

  static const apiUrl = "https://meltonapp.com/api/";
  static const users =  "users/";
  static const profile = "profile/";
  static const store_shop = "store/";
  static const store_buy = "buy/";
  static const post_preview = "posts/";

  String get token => GetIt.instance.get<TokenHandler>().getToken();

  Map<String, String> getAuthHeader() {
    return {"Authorization": token};
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

  Future<String> getAppToken(String email, String oauthToken,
      {String oauthProvider="GOOGLE"}) async {
    print("calling login/ ");
    print(email);
    print(oauthToken);
    print(oauthProvider);
    Map<String, String> jsonBodyMap = {
      "email": email,
      "token": oauthToken,
      "authProvider": oauthProvider
    };
    http.Response response = await http.post(apiUrl + "login/",
    headers: contentHeader,
    body: json.encode(jsonBodyMap)
    );
    print('print statuscode');
    print(response.statusCode);
    print('print body');
    print(response.body);
    print('print json body');
    print(jsonDecode(response.body)); //todo remove
    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      return jsonRes['appToken'];
    } else {
      return "";
    }
  }

  //add support for no internet error screen?
  // todo IMP - handle 403 case
  Future<bool> verifyAppTokenValid() async {
    print('verifying app token');
    print(getAuthHeader());
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
      List<dynamic> jsonResponse = json.decode(response.body);
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
      return UserModel.fromJson(json.decode(response.body));
    }
    else {
      //todo show error msg
      print("request failed");
    }
    return UserModel();
  }

  Future<ProfileModel> getProfile() async {
    http.Response response = await http.get(apiUrl + profile, headers: getAuthHeader());
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
    http.Response response = await http.get(apiUrl + store_shop, headers: getAuthHeader());
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

  Future<StoreItemBuy> buyStoreItem(int itemId) async {
    http.Response response = await http.post(apiUrl + store_buy,
        headers: getAuthAndJsonContentHeader(), body: """{"itemId":$itemId}""");
    bool result = handleError(response);
    if (result) {
      return StoreItemBuy.fromJson(json.decode(response.body));
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
    }
  }
  
  Future<List<PostModel>> getPostPreviewList(bool sendTopThree) async {
    http.Response response = await http.get(apiUrl + post_preview, headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      List<dynamic> jsonResponse = json.decode(response.body);
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

  Future<PostModel> getPostById(int postId) async {
    http.Response response = await http.get(apiUrl + post_preview + postId.toString(), headers: getAuthHeader());
    bool result = handleError(response);
    if (result) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      PostModel post = PostModel.fromJson(jsonResponse);
      return post;
    } else {
      // todo show error msg snackbar
      print("request failed, server is being cranky :(");
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
    } else {
      // some other error
      return false;
    }

  }

}