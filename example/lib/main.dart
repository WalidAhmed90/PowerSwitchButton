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
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      home: Scaffold(
        backgroundColor:
            Colors.white, // Sets the background color of the scaffold
        body: Center(
          child: PowerSwitchButton(
            size: 250.0, // Required: Size of the switch button
            strokeWidth: 9.0, // Required: Width of the dashed border
            dashWidth: 1.0, // Required: Width of each dash in the dashed border
            dashSpace:
                2.0, // Required: Space between each dash in the dashed border
            onColor: Colors.green, // Required: Color when the switch is on
            offColor: Colors.red, // Required: Color when the switch is off
            backgroundColor:
                Colors.grey[200]!, // Required: Background color of the switch
            iconColor:
                Colors.white, // Required: Color of the icon in the switch
            onToggle: (bool value) {
              // Required: Callback function that is triggered when the switch is toggled
              print(value); // Prints the switch state (on/off) to the console
            },
            shape: Shape
                .SQUARE, // Optional: Shape of the switch button (circle or square)
            borderRadius: 20, // Optional: Border radius for square shape
            customIcon: Icons
                .power_settings_new, // Optional: Custom icon for the switch
            label: 'Power Switch', // Optional: Label text inside the switch
            disabled: false, // Optional: Whether the switch is disabled or not
            onGradient: const LinearGradient(
              colors: [
                Colors.green,
                Colors.lightGreen
              ], // Optional: Gradient colors for the on state
            ),
            offGradient: const LinearGradient(
              colors: [
                Colors.red,
                Colors.orange
              ], // Optional: Gradient colors for the off state
            ),
            animationDuration: const Duration(
                milliseconds:
                    300), // Optional: Duration of the toggle animation
            animationCurve:
                Curves.bounceInOut, // Optional: Curve of the toggle animation
            loadingCallback: () async {
              // Optional: Callback function that handles the loading state
              await Future.delayed(
                  const Duration(seconds: 5)); // Simulates a loading delay
              return true; // Indicates successful loading
            },
            loadingText:
                "Loading..", // Optional: Text displayed during the loading state
          ),
        ),
      ),
    );
  }
}
