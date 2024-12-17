import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';

// Provider for managing the user's location
final locationProvider = StateProvider<Position?>((ref) => null);

// Provider for managing the selected emergency type
final emergencyTypeProvider = StateProvider<String>((ref) => '');

// Provider for managing the camera controller
final cameraControllerProvider = StateProvider<CameraController?>((ref) => null);