import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:lawod/pages/Fish%20Finder/scan_controller.dart';

class FishFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FishFinder'),
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                children: [
                  CameraPreview(controller.cameraController!),
                  Positioned(
                    top: (controller.y) * 100,
                    right: (controller.x) * 500,
                    child: Container(
                      width: controller.w * 100,
                      height: controller.h * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green, width: 4.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.white,
                              child: Text(controller.label),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
              : const Center(child: Text("Loading preview..."));
        },
      ),
    );
  }
}
