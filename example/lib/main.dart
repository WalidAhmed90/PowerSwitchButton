import 'package:flutter/material.dart';
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
            size: 200,
            strokeWidth: 4,
            dashWidth: 1,
            dashSpace: 2,
            onColor: Colors.red,
            offColor: Colors.grey,
            backgroundColor: Colors.black,
            iconColor: Colors.black54,
            onToggle: (bool isOn) {
              print('Switch is ${isOn ? 'On' : 'Off'}');
            },
          ),
        ),
      ),
    );
  }
}
