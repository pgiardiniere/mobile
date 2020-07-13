// https://medium.com/@aneesshameed/flutter-draggable-widget-daf81d232f36
import 'package:flutter/material.dart';

void main() {
  runApp(Demo1());
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable',
      home: Drag(),
    );
  }
}

class Drag extends StatefulWidget {
  Drag({Key key}) : super(key: key);
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  double top = 0;
  double left = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(30),
        height: 300,
        width: 300,
        color: Colors.indigo.shade200,
        child: Draggable(
          child: Container(
            padding: EdgeInsets.only(top: top, left: left),
            child: DragItem(),
          ),
          feedback: Container(
            padding: EdgeInsets.only(top: top, left: left),
            child: DragItem(),
          ),
          childWhenDragging: Container(),
          onDragCompleted: () {},
          onDragEnd: (drag) {
            setState(() {
              if ((top + drag.offset.dy) > (300.0 - 40.0)) {
                top = (300.0 - 40.0);
              } else if ((top + drag.offset.dy - 40.0) < 0.0) {
                top = 0;
              } else {
                top = top + drag.offset.dy - 40.0;
              }
              if ((left + drag.offset.dx) > (300.0 - 40.0)) {
                left = (300.0 - 40.0);
              } else if ((left + drag.offset.dx - 40.0) < 0.0) {
                left = 0;
              } else {
                left = left + drag.offset.dx - 40.0;
              }
            });
          },
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(IconData(57744, fontFamily: 'MaterialIcons'), size: 40);
  }
}
