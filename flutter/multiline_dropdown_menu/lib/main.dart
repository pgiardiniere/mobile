import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Test project')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: TestStatefulWidget(),
        ),
      ),
    ),
  );
}

class TestStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestStatefulWidgetState();
}

class TestStatefulWidgetState extends State<TestStatefulWidget> {
  static const List<String> shortItems = const [
    'These',
    'items',
    'are',
    'short',
    'enough',
  ];

  static const List<String> longItems = const [
    'These items will probably be longer than what fits on the screen correctly',
    'Because of this, the icon indicator on the right side will not show',
    'Instead, in development mode, a red indicator will display, showing something is wrong',
    'Short item',
    'This line is so long that it will not even fit on two lines (mostly because I\'ve added this pointless parenthetical statement and so we\'ll see the effect of TextOverflow.ellipsis',
  ];

  String shortSpinnerValue = shortItems[0];
  String longSpinnerValue = longItems[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButton<String>(
          value: shortSpinnerValue,
          onChanged: (String text) {
            setState(() {
              shortSpinnerValue = text;
            });
          },
          items: shortItems.map<DropdownMenuItem<String>>((String text) {
            return DropdownMenuItem<String>(
              value: text,
              child: Text(text),
            );
          }).toList(),
        ),
        SizedBox(height: 32),
        DropdownButton<String>(
          isExpanded: true,
          value: longSpinnerValue,
          onChanged: (String text) {
            setState(() {
              longSpinnerValue = text;
            });
          },
          selectedItemBuilder: (BuildContext context) {
            return longItems.map<Widget>((String text) {
              return Text(text, overflow: TextOverflow.ellipsis);
            }).toList();
          },
          items: longItems.map<DropdownMenuItem<String>>((String text) {
            return DropdownMenuItem<String>(
              value: text,
              child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      ],
    );
  }
}
