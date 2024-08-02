library power_switch_button;

import 'package:flutter/material.dart';

import 'dashed_circle_painter.dart';

/// A customizable switch button with animated on/off states and dashed border.
class PowerSwitchButton extends StatefulWidget {
  /// The size of the switch button.
  final double size;

  /// The stroke width of the dashed circle.
  final double strokeWidth;

  /// The width of each dash in the dashed circle.
  final double dashWidth;

  /// The space between each dash in the dashed circle.
  final double dashSpace;

  /// The color of the switch when it is in the 'on' position.
  final Color onColor;

  /// The color of the switch when it is in the 'off' position.
  final Color offColor;

  /// The background color of the switch.
  final Color backgroundColor;

  /// The color of the power icon.
  final Color iconColor;

  /// Callback that gets called when the switch is toggled.
  final ValueChanged<bool> onToggle;

  /// Creates a PowerSwitchButton widget.
  PowerSwitchButton({
    required this.size,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.onColor,
    required this.offColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.onToggle,
  });

  @override
  _PowerSwitchButtonState createState() => _PowerSwitchButtonState();
}

class _PowerSwitchButtonState extends State<PowerSwitchButton>
    with SingleTickerProviderStateMixin {
  bool isOn = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  /// Toggles the switch state and calls the onToggle callback.
  void _toggleSwitch() {
    setState(() {
      isOn = !isOn;
      widget.onToggle(isOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final outerCircleSize = widget.size;
    final middleCircleSize = widget.size * 0.8;
    final innerCircleSize = widget.size * 0.6;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: outerCircleSize,
          height: outerCircleSize,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            shape: BoxShape.circle,
          ),
        ),
        CustomPaint(
          size: Size(middleCircleSize, middleCircleSize),
          painter: DashedCirclePainter(
            strokeWidth: widget.strokeWidth,
            dashWidth1: widget.dashWidth,
            dashSpace1: widget.dashSpace,
            strokeColor: isOn ? widget.onColor : widget.offColor,
          ),
        ),
        GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            _toggleSwitch();
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: innerCircleSize,
              height: innerCircleSize,
              decoration: BoxDecoration(
                color: isOn ? widget.onColor : widget.offColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.power_settings_new,
                  size: innerCircleSize * 0.5,
                  color: widget.iconColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
