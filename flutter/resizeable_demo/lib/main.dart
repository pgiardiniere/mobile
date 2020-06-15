import 'package:flutter/material.dart';

// Toggle commented import line for the following 2 versions of widget.
//   The first import is first implementation, and is pretty rough.
//   The second import is the updated prototype, and feels better to use.

// import 'package:resizeable_demo/resize_widget.dart';
import 'package:resizeable_demo/updated_proto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Overflow Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Demo(),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      child: ResizebleWidget(
        child: Text(
'''I've just did simple prototype to show main idea.
  1. Draw size handlers with container;
  2. Use GestureDetector to get new variables of sizes
  3. Refresh the main container size.''',
        ),
      ),
    );
  }
}
