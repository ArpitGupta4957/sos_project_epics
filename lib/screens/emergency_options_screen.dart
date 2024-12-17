import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../emergency.dart'; // Importing the emergency providers
import '../widgets/emergency_button.dart'; // Importing the EmergencyButton widget

class EmergencyOptionsScreen extends HookConsumerWidget {
  const EmergencyOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Select Emergency Type',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    EmergencyButton(
                      title: 'Fire Emergency',
                      color: Colors.orange,
                      icon: Icons.local_fire_department,
                      onPressed: () {
                        ref.read(emergencyTypeProvider.notifier).state = 'Fire';
                        context.go('/form');
                      },
                    ),
                    const SizedBox(height: 16),
                    EmergencyButton(
                      title: 'Crime Emergency',
                      color: Colors.red,
                      icon: Icons.warning,
                      onPressed: () {
                        ref.read(emergencyTypeProvider.notifier).state = 'Crime';
                        context.go('/form');
                      },
                    ),
                    const SizedBox(height: 16),
                    EmergencyButton(
                      title: 'Medical Emergency',
                      color: Colors.blue,
                      icon: Icons.local_hospital,
                      onPressed: () {
                        ref.read(emergencyTypeProvider.notifier).state = 'Medical';
                        context.go('/form');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}