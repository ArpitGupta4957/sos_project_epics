import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:camera/camera.dart';
import '../emergency.dart'; // Importing the emergency providers

class CameraSection extends HookConsumerWidget {
  const CameraSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController = ref.watch(cameraControllerProvider);

    useEffect(() {
      return () {
        cameraController?.dispose();
      };
    }, [cameraController]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Media Capture'),
        const SizedBox(height: 8),
        if (cameraController != null && cameraController.value.isInitialized)
          SizedBox(
            height: 200,
            child: CameraPreview(cameraController),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text('Take Photo'),
                onPressed: () async {
                  final cameras = await availableCameras();
                  if (cameras.isNotEmpty) {
                    final controller = CameraController(
                      cameras.first,
                      ResolutionPreset.medium,
                    );
                    await controller.initialize();
                    ref.read(cameraControllerProvider.notifier).state = controller;
                  } else {
                    // Handle no cameras available
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No cameras available')),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.videocam),
                label: const Text('Record Video'),
                onPressed: () async {
                  final cameras = await availableCameras();
                  if (cameras.isNotEmpty) {
                    final controller = CameraController(
                      cameras.first,
                      ResolutionPreset.medium,
                    );
                    await controller.initialize();
                    ref.read(cameraControllerProvider.notifier).state = controller;
                  } else {
                    // Handle no cameras available
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No cameras available')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}