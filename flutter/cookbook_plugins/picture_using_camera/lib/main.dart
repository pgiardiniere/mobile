import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// So, this app has weird behavior on emulator.
// Emulated phone models:
//    Pixel 2 API 30
//    Pixel 3a XL API 29

// Pixel 2 throws exceptions. Pixel 3a XL works fine.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras[0];

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData.dark(),
    home: TakePictureScreen(camera: camera),
  ));
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({
    @required this.camera,
  });

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a photo')),
      // Display spinner until controller initializes
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      // Construct filepath using the 'path' package's shown join method.
      // It joins a directory (location to drop file) with a string (filename).

      // Get the temp directory's location using the 'path_provider' package's
      // getTemporaryDirectory().
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          await _initializeControllerFuture;
          final path = join(
              await getTemporaryDirectory().then((tempDir) => tempDir.path),
              '${DateTime.now()}.png');

          await _controller.takePicture(path);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: path)));
        } catch (e) {
          print(e);
        }
      }),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display that pic')),
      body: Image.file(File(imagePath)),  // need to import dart:io for File
    );
  }
}
