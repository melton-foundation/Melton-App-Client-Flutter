import 'package:flutter/material.dart';

import 'package:melton_app/screens/store.dart';
import 'package:melton_app/constants/constants.dart' as Constants;

class StoreLineItem extends StatefulWidget {

  final int points;

  StoreLineItem({this.points});

  @override
  _StoreLineItemState createState() => _StoreLineItemState(latestPoints: points);
}

class _StoreLineItemState extends State<StoreLineItem> {

  int latestPoints;

  _StoreLineItemState({this.latestPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.meltonBlue,
        border: Border.all(
          color: Constants.meltonYellow,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("IMPACT POINTS:", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
            Text(latestPoints.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
            RaisedButton(
              onPressed: () async {
                final storeBoughtPoints = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => Store(currentPoints: widget.points)));
                setState(() {
                  latestPoints = storeBoughtPoints;
                });
              },
              child: Text("OPEN STORE!", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
              color: Constants.meltonYellow,
              splashColor: Constants.meltonRed,
              animationDuration: Duration(seconds: 1),
              ),
          ],
        ),
      ),
    );
  }
}
