import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'package:melton_app/models/ProfileModel.dart';
import 'package:melton_app/constants/constants.dart';
import 'package:melton_app/util/world_cities.dart';

import 'package:melton_app/screens/components/profile_edit_social_media_item.dart';
import 'package:melton_app/screens/components/profile_save.dart';

class ProfileEdit extends StatefulWidget {
  final ProfileModel initialModel;

  ProfileEdit({this.initialModel});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  ProfileModel _model;
  PhoneNumber _phoneModel = PhoneNumber();
  SocialMediaAccounts _socialModel = SocialMediaAccounts(others: new List<String>());
  SDGList _sdgModel = SDGList.profileUpdateConstructor();

  final phoneNumberRegex = RegExp(r"^\+[0-9]{1,3}\ [0-9]{4}[0-9]*$");
  final int currentYear = DateTime.now().year;

  static const String OTHER_CAMPUS = "Other";
  static const int FIRST_BATCH = 1991;

  @override
  Widget build(BuildContext context) {
    _phoneModel = widget.initialModel.phoneNumber;
    _socialModel = widget.initialModel.socialMediaAccounts;
    _sdgModel = widget.initialModel.SDGs;
    _model = createProfileModelFromInitialModel(widget.initialModel, _phoneModel, _socialModel, _sdgModel);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Your Profile")),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                TextFormField(
                  maxLength: 60,
                  initialValue: widget.initialModel.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Hey there! Enter your name...";
                    }
                    return null;
                  },
                  onSaved: (String newValue) {
                    _model.name = newValue;
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
                  onSaved: (String newValue) {
                    _model.work = newValue;
                  },
                ),

                Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                Text("City", style: TextStyle(color: Constants.meltonBlue),),
                Row(
                  children: [
                    Icon(Icons.home, color: Colors.grey,),
                    SizedBox(width: 10,),
                    Expanded(
                      child: SearchableDropdown.single(
//                key: _formKey, //todo required?
                        value: widget.initialModel.city,
                        hint: "------------------------",
                        searchHint: "Search city or country",
                        items: WorldCities.WORLD_CITIES.keys.toList().map((s) {
                          return DropdownMenuItem<String>(
                            value: s,
                            child: Text(s),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          String newCity = newValue.split(",")[0];
                          String newCountry = newValue.split(",")[1];
                          _model.city = newCity;
                          _model.country = newCountry;
                        },
                        isExpanded: true,
                        closeButton: "DONE",
                        displayClearIcon: false,
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
                        onChanged: (String newValue) {},
                        onSaved: (String newValue) {
                          _model.campus = newValue;
                        },
                        items: Constants.campuses.map<DropdownMenuItem<String>>((s) {
                          return DropdownMenuItem<String>(
                            value: s,
                            child: Text(s),
                          );
                        }).toList(),
                        value: Constants.campuses.contains(widget.initialModel.campus) ?
                        widget.initialModel.campus : OTHER_CAMPUS,
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
                        onSaved: (String newValue) {
                          _model.batch = int.parse(newValue);
                        },
                        onChanged: (String newValue) {},
                        items: new List<int>.generate(currentYear - FIRST_BATCH + 1,
                                (index) => FIRST_BATCH + index).map((e) => e.toString()).toList().reversed.map<DropdownMenuItem<String>>((s) {
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
                  initialValue: isPhoneNumberPresent(widget.initialModel.phoneNumber) ?
                  ("+" + widget.initialModel.phoneNumber.countryCode + " " + widget.initialModel.phoneNumber.phoneNumber) : "",
                  validator: (value) {
                    if (value.isNotEmpty && !isPhoneNumberFormatted(value)) {
                      return "'+CC XXXXXXXXXX', 'CC' is country code";
                    }
                    return null;
                  },
                  onSaved: (String newValue) {
                    if (newValue.length == 0) {
                      return;
                    }
                    List<String> strings = newValue.substring(1).split(RegExp("\\s+"));
                    _phoneModel.countryCode = strings[0];
                    _phoneModel.phoneNumber = strings[1];
                  },
                  maxLength: 30,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone number",
                    icon: Icon(Icons.phone),
                  ),
                ),

                Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                Text("UN SDGs you care about", style: TextStyle(color: Constants.meltonBlue),),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.handHoldingHeart, color: Colors.grey,),
                    SizedBox(width: 10,),
                    //todo map sdgs from /profile to be preselected
                    //todo validate sdg dropdown before saving
                    SearchableDropdown.multiple(
//                key: _formKey, //todo required?
                    selectedItems: getSDGNumsFromSDGList(widget.initialModel.SDGs),
                    hint: "------------------------",
                    searchHint: "Select up to 3",
                    items: Constants.SDGs.values.toList().map((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      onChanged: (selections) {},
//                    print(selections);
//                      setState(() {
////                        selections.
//                      });
//                    },
                      validator: (selections) {
                        if (selections.length > 3)  {
                          return "Maximum 3 selections allowed!";
                        }
                        if (selections.length == 0) {
                          return "Select at least 1";
                        }
                        return null;
                      },
                      doneButton: (selections, doneContext) {
                        return (RaisedButton(
                            onPressed: isInvalidSDGsSelection(selections.length)
                                ? null
                                : () {
                                setSDGModelFromSelections(selections);
                                Navigator.pop(doneContext);
                            },
                            child: Text("DONE")));
                      },
                      //todo make close as dismiss and dont save changed items
                      closeButton: null,
                      displayClearIcon: false,
//                    closeButton: (selections) {
//                      return isInvalidSDGsSelection(selections.length) ? null : "DONE";
//                    },
                    ),
                  ],
                ),

                // todo - implicitly convert "weixin" to wechat?
                Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                Text("Social Media", style: TextStyle(color: Constants.meltonBlue),),
                Column(
                  children: [
                    ProfileEditSocialMediaItem(_socialModel),

                  ],
                ),

                //todo remaining dropdowns and fields

                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("UPDATE PROFILE", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print("VALID");
                      //todo POST api call
                      // todo based on true/false, show toast notification/snackbar?
                      _model.phoneNumber = _phoneModel;
                      _model.socialMediaAccounts = _socialModel;
                      _model.SDGs = _sdgModel;
                      bool saveSuccess = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => ProfileSave(profileModel: _model,)));
                      if (saveSuccess != null && saveSuccess == true) {
                        Navigator.pop(context, true);
                      } else {
                        Navigator.pop(context, false);
                      }
                    }
                  },
                ),
              ],
            ),
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

  void setSDGModelFromSelections(List<int> selections) {
    if (selections.length == 0) {
      _sdgModel.firstSDG = 0;
      _sdgModel.secondSDG = 0;
      _sdgModel.thirdSDG = 0;
      return;
    }

    _sdgModel.firstSDG = null;
    _sdgModel.secondSDG = null;
    _sdgModel.thirdSDG = null;

    if (selections.length >= 1) {
      _sdgModel.firstSDG = selections[0] + 1;
    }
    if (selections.length >= 2) {
      _sdgModel.secondSDG = selections[1] + 1;
    }
    if (selections.length == 3) {
      _sdgModel.thirdSDG = selections[2] + 1;
    }
  }

  //todo move static methods to new util class
  static bool isPhoneNumberPresent(PhoneNumber phoneNumberMap) {
    if (phoneNumberMap.countryCode.length > 0 &&
        phoneNumberMap.phoneNumber.length > 0) {
      return true;
    }
    return false;
  }

  static List<int> getSDGNumsFromSDGList(SDGList sdgList) {
    List<int> sdgNums = List<int>();
    if (sdgList.firstSDG != 0) {
      sdgNums.add(sdgList.firstSDG);
    }
    if (sdgList.secondSDG != 0) {
      sdgNums.add(sdgList.secondSDG);
    }
    if (sdgList.thirdSDG != 0) {
      sdgNums.add(sdgList.thirdSDG);
    }
    return sdgNums;
  }

  static bool isInvalidSDGsSelection(int selectionLength) {
    if (selectionLength == 0 || selectionLength > 3) {
      return true;
    }
    return false;
  }

  createProfileModelFromInitialModel(ProfileModel initialModel, PhoneNumber phoneModel,
      SocialMediaAccounts socialModel, SDGList sdgModel) {
    return ProfileModel(
      name: initialModel.name,
      campus: initialModel.campus,
      city: initialModel.city.split(",")[0],
      country: initialModel.city.split(",")[1],
      batch: initialModel.batch,
      work: initialModel.work,
      phoneNumber: phoneModel,
      socialMediaAccounts: socialModel,
      SDGs: sdgModel
    );
  }

}
