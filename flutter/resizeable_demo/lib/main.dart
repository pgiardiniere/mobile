import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';

import 'package:resizeable_demo/resizable.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MaterialApp(
    title: 'Text Overflow Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('Demos'),
      ),
      // body: Demo(),
      body: Demo2(),
    ),
  ));
}

// Demo implements features via the code sample derived Resizable.
class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/liquid.jpg'),
          Resizable(
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

// Demo2 implements features via the code sample derived Resizable
// It also overlays the reticle on a live camera preview, not a static image.
class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    // FOUND THE BUG.
    // For some reason, wrapping with a column causes an infinite overflow on bot.
    return // Column(children: <Widget>[
      Stack(children: <Widget>[
        ClipRect(
          child: Align(
            alignment: Alignment.center,
            heightFactor: 0.8,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Resizable(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
              'assets/images/stencil_art_transparent.png',
            ),
          ),
        ),
      ]);
    // ]);
  }
}
