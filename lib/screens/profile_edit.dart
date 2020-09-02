import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:melton_app/models/ProfileModel.dart';

import 'package:melton_app/constants/constants.dart';

class ProfileEdit extends StatefulWidget {
  final ProfileModel initialModel;

  ProfileEdit({this.initialModel});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberRegex = RegExp(r"^\+[0-9]{1,3}\ [0-9]{4}[0-9]*$");

  static const String OTHER = "Other";
  static const int FIRST_BATCH = 1991;
  final int currentYear = DateTime.now().year;

  String campusEdited = OTHER;
  String cityEdited;
  int batchEdited;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Your Profile")),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                maxLength: 40,
                initialValue: widget.initialModel.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Hey there! Enter your name...";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  icon: Icon(Icons.account_box),
                ),
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              TextFormField(
                initialValue: widget.initialModel.work,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Work info",
                  icon: Icon(Icons.business_center),
                ),
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              Text("Your city", style: TextStyle(color: Constants.meltonBlue),),
              Row(
                children: [
                  Icon(Icons.home, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          cityEdited = newValue;
                        });
                      },
                      //todo create searchable dropdown with full cities listt
                      items: Constants.campuses.map<DropdownMenuItem<String>>((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      value: Constants.campuses.contains(widget.initialModel.campus) ?
                      widget.initialModel.campus : OTHER,
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              Text("Melton Campus", style: TextStyle(color: Constants.meltonBlue),),
              Row(
                children: [
                  Icon(FontAwesomeIcons.university, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          cityEdited = newValue;
                        });
                      },
                      items: Constants.campuses.map<DropdownMenuItem<String>>((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      value: Constants.campuses.contains(widget.initialModel.campus) ?
                      widget.initialModel.campus : OTHER,
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              Text("Melton Batch - the year you got in", style: TextStyle(color: Constants.meltonBlue),),
              Row(
                children: [
                  Icon(FontAwesomeIcons.solidCalendarTimes, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          batchEdited = int.parse(newValue);
                        });
                      },
                      items: new List<int>.generate(currentYear - FIRST_BATCH + 1,
                              (index) => FIRST_BATCH + index).map((e) => e.toString()).toList().map<DropdownMenuItem<String>>((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      value: new List<int>.generate(currentYear - FIRST_BATCH + 1,
                              (index) => FIRST_BATCH + index).map((e) => e.toString()).toList()
                          .contains(widget.initialModel.batch.toString()) ?
                      widget.initialModel.batch.toString() : FIRST_BATCH.toString(),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              TextFormField(
                initialValue: "+" + widget.initialModel.phoneNumber.countryCode + " " + widget.initialModel.phoneNumber.phoneNumber,
                validator: (value) {
                  if (value.isNotEmpty && !isPhoneNumberFormatted(value)) {
                    return "'+CC XXXXXXXXXX' - 'CC' is country code";
                  }
                  return null;
                },
                maxLength: 30,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone number",
                  icon: Icon(Icons.phone),
                ),
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              //social media

              Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
              //SDGs

              //todo use this pacakage for sdg and city?
              // https://pub.dev/packages/searchable_dropdown
              //
            // todo - social media either dropdown or indicate which icons have first-class support??
              // todo - implicitly convert "weixin" to wechat?

              //todo remaining dropdowns and fields

              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text("UPDATE MY PROFILE", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  // todo validate and save form
                  //todo POST api call
                  // todo based on true/false, show toast notification/snackbar?
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isPhoneNumberFormatted(String str) {
    if (phoneNumberRegex.hasMatch(str)) {
      return true;
    }
    return false;
  }
}
