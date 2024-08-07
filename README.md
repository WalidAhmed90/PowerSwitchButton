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
- **Loading State:** Show an intermediate loading state with animation while the switch is processing.



## Demo

Simple button without loading state:

![PowerSwitchButton](https://github.com/user-attachments/assets/5f0e865a-ec62-494b-9619-a6c8c208d445)

Power Switch Button with loading State:

![PowerButtonSwitchSqure](https://github.com/user-attachments/assets/1e3f9ea2-4d8e-457a-b292-a7240a38597a)  ![PowerSwitchButtonCircle](https://github.com/user-attachments/assets/3c383a16-d641-41f1-a9f6-4b4fcd674344)


## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  power_switch_button: ^0.0.5
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
- **loadingCallback:** A function to be called when the switch is loading, returning a Future<bool> indicating success or failure (optional). 
- **loadingText:** Text to display while the switch is in the loading state (optional).



## License

This package is licensed under the MIT License. See the 
[LICENSE](https://github.com/WalidAhmed90/PowerSwitchButton/blob/main/LICENSE) file for more details.





