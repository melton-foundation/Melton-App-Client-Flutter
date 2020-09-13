import 'package:flutter/material.dart';

import 'package:melton_app/api/api.dart';

import 'package:melton_app/models/UserRegisterModel.dart';
import 'package:melton_app/models/UserRegisterResponseModel.dart';

class UserRegister extends StatefulWidget {
  final UserRegisterModel model;

  UserRegister({this.model});

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  Future<UserRegisterResponseModel> _response;

  @override
  Widget build(BuildContext context) {
    _response = ApiService().postRegisterUser(widget.model);
    return FutureBuilder<UserRegisterResponseModel>(
      future: _response,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator())
              )
          );
        }
        if (snapshot.hasData) {
          print('user register success');
          print(snapshot.data.isUserExists);
          print(snapshot.data.appToken);
          print(snapshot.data.emailMessage);
          //todo remove future.delayed from everywhere?
          Future.delayed(Duration(seconds: 2));
          //todo make model and confirm if user exists
          print("popping user register");
          Navigator.pop(context, snapshot.data);
        }
        if (snapshot.hasError) {
          print('user register has error');
          print(snapshot.error);
          Navigator.pop(context, false);
        }
        return Container();
      },
    );
  }
}
