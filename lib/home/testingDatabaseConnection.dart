import 'package:flutter/material.dart';

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Name",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, 
                width: 2.0)
              )
            ),
          )
        ],
      ),
    );
  }
}
