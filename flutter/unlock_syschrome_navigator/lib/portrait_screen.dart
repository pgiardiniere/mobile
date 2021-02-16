import 'package:flutter/material.dart';

import 'routes.dart';

class PortraitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Portrait")),
      body: Column(
        children: <Widget>[
          Center(child: Text("This is the portrait-only screen")),
          RaisedButton(
              child: Text("Rotating screen"),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.rotating),
            ),
        ],
      ),
    );
  }
}
