import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../emergency.dart'; // Importing the emergency providers

class LocationStatus extends HookConsumerWidget {
  const LocationStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    
    useEffect(() {
      Geolocator.getCurrentPosition().then((position) {
        ref.read(locationProvider.notifier).state = position;
      }).catchError((error) {
        // Handle location error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get location')),
        );
      });
      return null;
    }, const []);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        location != null
            ? '✓ Location acquired successfully'
            : '⌛ Getting your location...',
        textAlign: TextAlign.center,
      ),
    );
  }
}