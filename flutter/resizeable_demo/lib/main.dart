import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:camera/camera.dart';
import 'package:resizeable_demo/resize_widget.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
        // body: Demo2(),
        body: Demo3(),
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
              child: Image.asset(
                'assets/images/transparent_reticle.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Demo2 implements features via the PhotoView package.
// Due to issues down the line with gesture capturing, it doesn't do it all.
class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Stack(children: <Widget>[
        PhotoView(
          imageProvider: AssetImage('assets/images/liquid.jpg'),
        ),
      ]),
    );
  }
}

// Demo3 implements features via the code sample derived ResizableWidget
// It also overlays the reticle on a live camera preview, not a static image.
class Demo3 extends StatefulWidget {
  @override
  _Demo3State createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),

          ResizableWidget(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/stencil_art_transparent.png',),
            ),
          ),
        ]
      ),
    );
  }
}
