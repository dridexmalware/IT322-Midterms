import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';
import 'dart:developer' as developer;

class ScanController extends GetxController {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  var x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  var label = "";

  @override
  void onInit() {
    super.onInit();
    initCamera(); // Prioritize camera initialization
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose(); // Ensure proper disposal
  }

  Future<void> initCamera() async {
    try {
      if (await Permission.camera.request().isGranted) {
        cameras = await availableCameras();
        cameraController = CameraController(cameras![0], ResolutionPreset.max);
        await cameraController!.initialize();

        await initTFLite(); // Load TFLite after camera setup

        cameraController!.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });

        isCameraInitialized(true);
      } else {
        developer.log("Camera permission denied");
      }
    } catch (error) {
      developer.log("Error initializing camera: $error");
      // Handle camera initialization errors gracefully
    }
  }

  Future<void> initTFLite() async {
    try {
      await Tflite.loadModel(
        model: "assets/tensor/model.tflite",
        labels: "assets/tensor/labels.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false,
      );
      developer.log("TFLite model loaded successfully");
    } catch (error) {
      developer.log("Error loading TFLite model: $error");
      // Handle model loading errors gracefully
    }
  }

  Future<void> objectDetector(CameraImage image) async {
    try {
      var detector = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        asynch: true,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5, // Adjust based on model requirements
        imageStd: 127.5, // Adjust based on model requirements
        numResults: 1,
        rotation: 90,
        threshold: 0.4,
      );

      if (detector != null && detector.isNotEmpty) {
        var ourDetectorObject = detector.first;
        if (ourDetectorObject['confidenceInClass'] * 100 > 45) {
          label = ourDetectorObject['detectedClass'].toString();
          h = ourDetectorObject['rect']['h'];
          w = ourDetectorObject['rect']['w'];
          x = ourDetectorObject['rect']['x'];
          y = ourDetectorObject['rect']['y'];
        }
      }
    } catch (error) {
      developer.log("Error in object detection: $error");
      // Handle object detection errors gracefully
    }
    update();
  }
}
