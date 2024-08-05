import 'package:flutter/material.dart';
import 'package:power_switch_button/enum.dart';
import 'package:power_switch_button/power_switch_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: PowerSwitchButton(
            size: 250.0,
            strokeWidth: 6.0,
            dashWidth: 1.0,
            dashSpace: 2.0,
            onColor: Colors.green,
            offColor: Colors.red,
            backgroundColor: Colors.grey[200]!,
            iconColor: Colors.white,
            onToggle: (bool value) {
              print('Switch is: $value');
            },
            shape: Shape.SQUARE,
            borderRadius: 20,
            customIcon: Icons.power_settings_new, // Optional: custom icon
            label: 'Power Switch', // Optional: label text
            disabled: false, // Optional: disabled state
            onGradient: const LinearGradient(
              // Optional: on gradient colors
              colors: [Colors.green, Colors.lightGreen],
            ),
            offGradient: const LinearGradient(
              // Optional: off gradient colors
              colors: [Colors.red, Colors.orange],
            ),
            animationDuration: const Duration(
                milliseconds: 300), // Optional: custom animation duration
            animationCurve:
                Curves.bounceInOut, // Optional: custom animation curve
          ),
        ),
      ),
    );
  }
}
