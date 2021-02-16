import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

/// To use the simple/accepted solution for external State access detailed here:
/// https://stackoverflow.com/questions/46057353/controlling-state-from-outside-of-a-statefulwidget
///
/// To use context.findAncestorStateOfType, you require 2 things:
///   1) The .of() callee to be contained in the current BuildContext's widget tree.
///   2) The .of() caller to be below the callee in the widget tree.
///
/// NOTE: this is not a very good way of doing state management.
/// See the other projects in this dir.
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Counter(
            child: Builder(builder: (context) {
              return Container(
                height: 100,
                width: 100,
                color: Colors.black26,
                child: Center(
                  child: RaisedButton(
                    child: Text("ext inc"),
                    onPressed: Counter.of(context).increment,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  static _CounterState of(BuildContext context) =>
      context.findAncestorStateOfType<_CounterState>();

  final Widget child;
  Counter({this.child});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = 0;
  }

  void increment() {
    setState(() {
      _counter++;
    });
    print(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 400,
        height: 600,
        color: Colors.black26,
        child: Center(
          child: RaisedButton(child: Text("increment"), onPressed: increment),
        ),
      ),
      widget.child,
    ]);
  }
}
