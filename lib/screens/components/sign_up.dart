import 'package:flutter/material.dart';

import 'package:melton_app/constants/constants.dart' as Constants;
import 'package:melton_app/models/UserRegisterModel.dart';
import 'package:melton_app/models/UserRegisterResponseModel.dart';

import 'package:melton_app/screens/main_home.dart';
import 'package:melton_app/screens/components/user_register.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  UserRegisterModel _model = UserRegisterModel.getDefaultModel();

  final int currentYear = DateTime.now().year;
  static const FIRST_BATCH = 1991;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              FormTitle("NAME"),
              TextFormField(
                maxLength: 60,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter your name!";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _model.name = newValue;
                },
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              FormTitle("EMAIL"),
              FormSubtitle("Use your Google account"),
              TextFormField(
                maxLength: 60,
                validator: (value) {
                  if (!value.contains("@")) {
                    return "Enter a Google account!";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _model.email = newValue;
                },
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              FormTitle("CAMPUS"),
              DropdownButtonFormField<String>(
                isExpanded: true,
                onChanged: (String newValue) {
                  _model.campus = newValue;
                },
                onSaved: (String newValue) {
                  _model.campus = newValue;
                },
                items: Constants.campuses.map<DropdownMenuItem<String>>((s) {
                  return DropdownMenuItem<String>(
                    value: s,
                    child: Text(s),
                  );
                }).toList(),
                value: Constants.campuses[0],
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              FormTitle("BATCH"),
              FormSubtitle("The year you got in"),
              DropdownButtonFormField<String>(
                isExpanded: true,
                onSaved: (String newValue) {
                  _model.batch = int.parse(newValue);
                },
                onChanged: (String newValue) {
                  _model.batch = int.parse(newValue);
                },
                items: new List<int>.generate(currentYear - FIRST_BATCH + 1,
                        (index) => FIRST_BATCH + index).map((e) => e.toString())
                    .toList().reversed.map<DropdownMenuItem<String>>((s) {
                      return DropdownMenuItem<String>(
                        value: s,
                        child: Text(s),
                      );
                }).toList(),
                value: FIRST_BATCH.toString(),
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              FormTitle("WORK / BIO"),
              FormSubtitle("Something about yourself"),
              TextFormField(
                maxLength: 200,
                maxLines: 2,
                onSaved: (newValue) {
                  if (newValue.isNotEmpty) {
                    _model.work = newValue;
                  }
                },
              ),

              RaisedButton(
                child: Text("REGISTER", style: TextStyle(color: Colors.white),),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  bool dialogShown = false;
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    UserRegisterResponseModel response = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserRegister(model: _model,))
                    );

                    if (response.isUserExists != null && response.isUserExists) {
                      dialogShown = true;
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("USER EXISTS!"),
                          content: Text("Try signing in with the same email."),);
                      });
                    } else if (response.emailMessage != null) {
                      dialogShown = true;
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text(response.emailMessage),);
                      });
                    }
                    if (response.appToken != null) {
                      dialogShown = true;
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("SUCCESS! YOU CAN SIGN IN!"),);
                      });
                    }

                    if (!dialogShown) {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("OOPS!"), content: Text("Something went wrong. Try again :("),);
                      });
                    }

                    print(response.isUserExists);
                    print(response.emailMessage);
                    print(response.appToken);
                  } else {
                    return showDialog(context: context, builder: (context) {
                      return AlertDialog(title: FormTitle("FILL IN THE MISSING FIELDS"),);
                    });
                  }
                },
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              RaisedButton(
                child: Text("CLOSE", style: TextStyle(color: Colors.white),),
                color: Constants.meltonRedAccent,
                onPressed: () {
                  Navigator.pop(context);
                }
              ),

              SizedBox(height: 200,),

            ],
          ),
        ),
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String text;

  FormTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Constants.meltonBlue,
        fontWeight: FontWeight.bold, fontSize: 18),);
  }
}

class FormSubtitle extends StatelessWidget {
  final String text;

  FormSubtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Constants.meltonBlue, fontSize: 14),);
  }
}


