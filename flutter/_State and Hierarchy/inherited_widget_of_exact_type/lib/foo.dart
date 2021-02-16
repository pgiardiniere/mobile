import 'package:flutter/material.dart';

// First, we have an InheritedWidget that expose a count :

class Count extends InheritedWidget {
  static of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Count>();

  final int count;

  Count({Key key, @required Widget child, @required this.count})
      : assert(count != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(Count oldWidget) {
    return this.count != oldWidget.count;
  }
}

class _CountState extends State<Count> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Count(
      count: count,
      child: Scaffold(
        body: CountBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
        ),
      ),
    );
  }
}

class CountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Count.of(context).count.toString()),
    );
  }
}