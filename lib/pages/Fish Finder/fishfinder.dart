import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

class FishFinder extends StatelessWidget {
  const FishFinder ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FishFinder(),
    );
  }
}