import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:resizeable_demo/resize_widget.dart';

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
        // body: Demo(),
        body: Demo2(),
      ),
    );
  }
}


// Demo implements features via the code sample derived ResizableWidget.
class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/liquid.jpg'),
          ResizableWidget(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/stencil_art_transparent.png',),
            ),
          ),
        ],
      ),
    );
  }
}

// Demo2 implements features via the photo_view package.
class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Stack(
        children: <Widget>[
          PhotoView(imageProvider: AssetImage('assets/images/liquid.jpg'),),
        ]
      ),
    );
  }
}
