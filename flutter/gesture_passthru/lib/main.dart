import 'package:flutter/material.dart';

import './carousel.dart';

/// Below samples are pulled from:
/// https://github.com/flutter/flutter/issues/47434

class BrokenGesturesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter View',
      theme: ThemeData.dark(),
      home: BrokenHomePage(),
    );
  }
}

class FixedGesturesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter View',
      theme: ThemeData.dark(),
      home: Scaffold(body: FixedHomePage()),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Home()));
  // runApp(BrokenGesturesDemo());
  // runApp(FixedGesturesDemo());
}

class Home extends StatelessWidget {
  Future<void> takePhoto() async {
    print("waiting...");
    await Future.delayed(Duration(milliseconds: 500));
    print("waited. Take photo returning");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yo'), centerTitle: true),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        FractionallySizedBox(heightFactor: .75, widthFactor: 1),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.75)),
        ),
        Carousel(takePhotoCallback: takePhoto)
      ]),
    );
  }
}

class BrokenHomePage extends StatefulWidget {
  @override
  _BrokenHomePageState createState() => _BrokenHomePageState();
}

class _BrokenHomePageState extends State<BrokenHomePage> {
  PageController _scrollController = PageController();
  int _numPages = 3;
  PageView pageView;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _scrollController,
            children: <Widget>[
              Container(color: Colors.red),
              Container(color: Colors.green),
              Container(color: Colors.blue),
            ],
          ),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: GestureDetector(
                onTap: () => print('tapped on the smaller one'),
                child: Container(
                  color: Colors.black38,
                  child: Container(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child:
                            Text("Tap here", style: TextStyle(fontSize: 16))),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: GestureDetector(
                onTap: () => print('tapped on the bigger one'),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  color: Colors.black38,
                  child: Container(
                    child: Center(
                        child: Text("Drag on this container",
                            style: TextStyle(fontSize: 25))),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FixedHomePage extends StatefulWidget {
  @override
  _FixedHomePageState createState() => _FixedHomePageState();
}

class _FixedHomePageState extends State<FixedHomePage> {
  PageController _scrollController = PageController();
  int _numPages = 3;
  PageView pageView;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _scrollController,
          children: <Widget>[
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
          ],
        ),
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: GestureDetector(
              onDoubleTap: () => Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('dtap on the smaller one'),
                  duration: Duration(milliseconds: 800),
                ),
              ),
              onLongPress: () => Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('hold on the smaller one'),
                  duration: Duration(milliseconds: 800),
                ),
              ),
              behavior: HitTestBehavior.translucent,
              child: IgnorePointer(
                child: Container(
                  color: Colors.black38,
                  child: Container(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child:
                            Text("Tap here", style: TextStyle(fontSize: 16))),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: GestureDetector(
              onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('tapped on the bigger one'),
                duration: Duration(milliseconds: 800),
              )),
              behavior: HitTestBehavior.translucent,
              child: IgnorePointer(
                child: Container(
                  color: Colors.black38,
                  child: Container(
                    child: Center(
                        child: Text("Drag on this container",
                            style: TextStyle(fontSize: 25))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
