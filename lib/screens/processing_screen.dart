import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../emergency.dart'; // Importing the emergency providers

class ProcessingScreen extends HookConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = useState<List<String>>([]);
    
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () {
        steps.value = [...steps.value, 'Analyzing media content...'];
      });
      Future.delayed(const Duration(seconds: 2), () {
        steps.value = [...steps.value, 'Verifying emergency...'];
      });
      Future.delayed(const Duration(seconds: 3), () {
        steps.value = [...steps.value, 'Locating nearest response unit...'];
      });
      Future.delayed(const Duration(seconds: 4), () {
        final emergencyType = ref.read(emergencyTypeProvider);
        String message = '';
        switch (emergencyType) {
          case 'Fire':
            message = 'Nearest fire station has been notified and dispatched!';
            break;
          case 'Crime':
            message = 'Nearest police station has been alerted and units are en route!';
            break;
          case 'Medical':
            message = 'Nearest hospital has been notified and ambulance dispatched!';
            break;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
      return null;
    }, const []);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            const Text(
              'Analyzing emergency and contacting nearest response unit...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ...steps.value.map((step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(step),
            )),
          ],
        ),
      ),
    );
  }
}
