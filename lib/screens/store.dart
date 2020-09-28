import 'package:flutter/material.dart';

import 'package:melton_app/models/StoreModel.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/constants/constants.dart';

class Store extends StatefulWidget {

  final int currentPoints;

  Store({this.currentPoints});

  @override
  _StoreState createState() => _StoreState(pointsIfBought: currentPoints);
}

class _StoreState extends State<Store> {
  Future<List<StoreModel>> _model = ApiService().getStoreItems();
  int pointsIfBought;

  _StoreState({this.pointsIfBought});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Melton Store")),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, pointsIfBought);
          return new Future(() => false); //todo verify "false"
        },
        child: FutureBuilder<List<StoreModel>>(
          future: _model,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(snapshot.data[index].image ?? ""),
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
                             snapshot.data[index].purchased ? Container(height: 40.0, width: 150.0,
                              color: Constants.meltonGreen,
                              child: Center(child: Text("BOUGHT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                            ) :
                            RaisedButton(
                              splashColor: Colors.amberAccent,
                              animationDuration: Duration(seconds: 2),
                              onPressed: (snapshot.data[index].points > pointsIfBought) ? null :
                              () => {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(title: Text("BUY ${snapshot.data[index].name}?"),
                                      content: Container(
                                        height: 175.0,
                                        width: 100.0,
                                        child: SingleChildScrollView(
                                          child:
                                          Text("Are you sure you want to buy ${snapshot.data[index].name} for ${snapshot.data[index].points} points? "
                                              "\n \n You've earned it :) \n \n No takebacks!"),
                                        ),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          elevation: 10.0,
                                          child: Text("YES, GO AHEAD", style: TextStyle(color: Constants.meltonBlue, fontWeight: FontWeight.bold),),
                                          onPressed: () async {
                                            StoreItemBuy item = await ApiService().buyStoreItem(snapshot.data[index].id);
                                            setState(() {
                                              _model = ApiService().getStoreItems();
                                              pointsIfBought = item.availablePoints;
                                            });
                                            Navigator.of(context).pop(pointsIfBought);
                                          },
                                        ),
                                        MaterialButton(
                                          elevation: 10.0,
                                          child: Text("NO, TAKE ME BACK", style: TextStyle(color: Constants.meltonRed, fontWeight: FontWeight.bold),),
                                          onPressed: () { Navigator.of(context).pop(); },
                                        ),
                                      ]
                                  );} )
                              } ,
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
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}"); //todo handle correctly
            }
            //todo make fun error screen
            return Center(child: Text("ERROR: SOMETHING WENT WRONG"));
          },
        ),
      ),
    );
  }
}
