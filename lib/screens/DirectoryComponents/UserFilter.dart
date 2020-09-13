import 'package:flutter/material.dart';

class UserFilter extends StatelessWidget {
  final String title;
  UserFilter({@required this.title});

  @override
  Widget build(BuildContext context) {
    int _value = 1;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
            color: Colors.red, style: BorderStyle.solid, width: 0.80),
        color: Colors.white,
      ),
      child: SizedBox(
        height: 35,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            focusColor: Colors.grey,
            items: [
              DropdownMenuItem(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Second"),
                value: 2,
              ),
              DropdownMenuItem(child: Text("Third"), value: 3),
              DropdownMenuItem(child: Text("Fourth"), value: 4)
            ],
            onChanged: (value) {},
            isExpanded: false,
            value: 1,
          ),
        ),
      ),
    );
  }
}
