import 'package:flutter/material.dart';
import 'package:responsive_util/responsive_util.dart';

void main() {
  runApp(MaterialApp(
    title: 'responsive_util demo',
    home: Demo1(),
  ));
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('responsive_util demo'),
      ),
      body: Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurple,
        padding: EdgeInsets.only(left: 150, top: 150, bottom: 50, right: 50),
        child: ResponsiveUtil(
          child: Container(color: Colors.green),
        ),
      ),
    );
  }
}
