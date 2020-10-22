import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:melton_app/api/api.dart';

import 'package:melton_app/models/UserRegisterModel.dart';
import 'package:melton_app/models/UserRegisterResponseModel.dart';
import 'package:melton_app/sentry/CustomExceptions/CustomExceptions.dart';
import 'package:melton_app/sentry/SentryService.dart';

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
                  child: Center(child: CircularProgressIndicator())));
        }
        if (snapshot.hasData) {
          Navigator.pop(context, snapshot.data);
        }
        if (snapshot.hasError) {
          GetIt.instance.get<SentryService>().reportErrorToSentry(
              error:
                  UserRegisterException("User Register : ${snapshot.error}"));
          Navigator.pop(context, false);
        }
        return Container();
      },
    );
  }
}
