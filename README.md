# PowerSwitchButton

PowerSwitchButton  is a versatile and customizable switch widget for Flutter that allows you to easily add a stylish toggle switch to your applications. With adjustable parameters for size, stroke width, dash width, and dash space, this widget provides a modern, eye-catching switch with customizable on and off colors.

## Features

- **Customizable Size:** Adjust the size of the switch to fit your design needs.
- **Adjustable Stroke and Dash:** Control the stroke width, dash width, and dash space to match your app's aesthetic.
- **Color Options:** Set different colors for the switch in its on and off states.
- **Callback Function:** Receive a callback with the switch state whenever it is toggled. 
- **Icon Customization:** Change the color of the icon and set a custom icon. 
- **Gradient Support:** Add gradients to the switch’s on and off states. 
- **Disabled State:** Optionally disable the switch.
- **Shape Options:** Choose between different shapes for the switch button. 
- **Animation Customization:** Adjust the animation duration and curve.


## Demo


![PowerSwitchButton](https://github.com/user-attachments/assets/5f0e865a-ec62-494b-9619-a6c8c208d445)


## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  power_switch_button: ^0.0.4
```


## Usage

Import the Package

```dart
import 'package:power_switch_button/power_switch_button.dart';
import 'package:power_switch_button/enum.dart';

```

## Basic Example

Here is a basic example of how to use the PowerSwitchButton widget in your application:

```dart
import 'package:flutter/material.dart';
import 'package:power_switch_button/power_switch_button.dart';
import 'package:power_switch_button/enum.dart';


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
            strokeWidth: 3.0,
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
            borderRadius: 10,
            customIcon: Icons.power_settings_new,  // Optional: custom icon
            label: 'Power Switch',  // Optional: label text
            disabled: false,  // Optional: disabled state
            onGradient: LinearGradient(  // Optional: on gradient colors
              colors: [Colors.green, Colors.lightGreen],
            ),
            offGradient: LinearGradient(  // Optional: off gradient colors
              colors: [Colors.red, Colors.orange],
            ),
            animationDuration: Duration(milliseconds: 300),  // Optional: custom animation duration
            animationCurve: Curves.bounceInOut,  // Optional: custom animation curve
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
- **iconColor:** The color of the icon (e.g., Colors.black).
- **customIcon:** An optional custom icon to display in the switch (e.g., Icons.power_settings_new). 
- **label:** An optional label text to display inside the switch (e.g., 'Power Switch'). 
- **disabled:** A boolean to disable the switch (default is false). 
- **onGradient:** An optional gradient for the 'on' state (e.g., LinearGradient(colors: [Colors.green, Colors.lightGreen])). 
- **offGradient:** An optional gradient for the 'off' state (e.g., LinearGradient(colors: [Colors.red, Colors.orange])). 
- **shape:** The shape of the switch button (e.g., Shape.SQUARE). 
- **borderRadius:** The border radius for the square shape (e.g., 10). 
- **animationDuration:** The duration of the toggle animation (default is Duration(milliseconds: 300)). 
- **animationCurve:** The curve of the toggle animation (default is Curves.bounceInOut).
- **onToggle:** A callback function that receives the switch's state (true for on, false for off).


## License

This package is licensed under the MIT License. See the 
[LICENSE](https://github.com/WalidAhmed90/PowerSwitchButton/blob/main/LICENSE) file for more details.





