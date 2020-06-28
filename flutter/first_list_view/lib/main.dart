import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'First ListView',
    home: DynamicDemo(),
  ));
}

// Use the standard ListView constructor to display a few boxes on screen.
// https://api.flutter.dev/flutter/widgets/ListView-class.html
class StaticDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            // width: 100,
            height: 200,
            color: Colors.red,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(color: Colors.blue, width: 200, height: 200),
                Container(color: Colors.green, width: 200, height: 200),
                Container(color: Colors.orange, width: 200, height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Must use the ListView.builder named constructor when updating the ListView
// in a stateful context. Otherwise the ListView will not update with new elements.
// https://stackoverflow.com/questions/59429270/flutter-listview-button-to-create-extra-children
class DynamicDemo extends StatefulWidget {
  @override
  DynamicDemoState createState() => DynamicDemoState();
}

class DynamicDemoState extends State<DynamicDemo> {
  List<Widget> boxes = List<Widget>();

  void _generateBox() {
    setState(() {
      boxes.add(
        Container(
          width: 200,
          color: Colors.black,
          padding: EdgeInsets.all(5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.green,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.red,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: boxes.length,
              itemBuilder: (context, i) {
                return boxes[i];
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _generateBox();
      }),
    );
  }
}

class ThirdDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.red,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(color: Colors.blue, width: 200, height: 200),
                Container(color: Colors.green, width: 200, height: 200),
                Container(color: Colors.orange, width: 200, height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
