# PowerSwitchButton

PowerSwitchButton  is a versatile and customizable switch widget for Flutter that allows you to easily add a stylish toggle switch to your applications. With adjustable parameters for size, stroke width, dash width, and dash space, this widget provides a modern, eye-catching switch with customizable on and off colors.

## Features

- **Customizable Size:** Adjust the size of the switch to fit your design needs.
- **Adjustable Stroke and Dash:** Control the stroke width, dash width, and dash space to match your app's aesthetic.
- **Color Options:** Set different colors for the switch in its on and off states.
- **Callback Function:** Receive a callback with the switch state whenever it is toggled.


## Demo


![Screen_recording_20240801_143600-ezgif com-optimize](https://github.com/user-attachments/assets/0ee23477-80d5-4f8e-8b05-899ed79979eb)

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  power_switch_button: ^0.0.1
```


## Usage

Import the Package

```dart
import 'package:power_switch_button/power_switch_button.dart';
```

## Basic Example

Here is a basic example of how to use the CustomSwitch widget in your application:

```dart
import 'package:flutter/material.dart';
import 'package:power_switch_button/power_switch_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            onToggle: (bool isOn) {
              print('Switch is ${isOn ? 'On' : 'Off'}');
            },
          ),
        ),
      ),
    );
  }
}
```

## Parameters


- **size:** The size of the switch (e.g., 200).
- **strokeWidth:** The width of the dashed stroke (e.g., 4).
- **dashWidth:** The width of each dash in the dashed circle (e.g., 1).
- **dashSpace:** The space between each dash in the dashed circle (e.g., 2).
- **onColor:** The color of the switch when it is in the 'on' position (e.g., Colors.red).
- **offColor:** The color of the switch when it is in the 'off' position (e.g., Colors.grey).
- **backgroundColor:** The color of the switch background (e.g., Colors.black).
- **onToggle:** A callback function that receives the switch's state (true for on, false for off).


## License

This package is licensed under the MIT License. See the 
[LICENSE](https://github.com/WalidAhmed90/PowerSwitchButton/blob/main/LICENSE) file for more details.





