import 'package:flutter/material.dart';
import 'package:melton_app/models/StoreModel.dart';
import 'package:melton_app/api/api.dart';

import 'package:melton_app/constants/constants.dart' as Constants;

class Store extends StatefulWidget {

  final int currentPoints;

  Store({this.currentPoints});

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Future<List<StoreModel>> _model = ApiService().getStoreItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Melton Store")),
      body: FutureBuilder<List<StoreModel>>(
        future: _model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(snapshot.data[index].name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      Text(snapshot.data[index].description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40.0, width: 150.0,
                            color: Constants.meltonBlueAccent,
                            child: Center(child: Text(snapshot.data[index].points.toString() + " points",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                          ),
                          //todo add splash animation like store_line_item button?
                          RaisedButton(
                            onPressed: (snapshot.data[index].points > widget.currentPoints) ? null : () =>
                            //todo fix alertdialog
                              {AlertDialog(title: Text("R U SURE?"),
                              content: Container(
                                height: 175.0,
                                width: 100.0,
                                child: SingleChildScrollView(
                                  child: Text("R U SURE?"),
                                ),
                              ),
                            )} ,
                            child: Text("BUY", style: TextStyle(color: Constants.meltonBlue, fontWeight: FontWeight.bold),),
                            color: Constants.meltonYellow,

                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}"); //todo handle correctly
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
