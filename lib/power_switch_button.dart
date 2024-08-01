library power_switch_button;

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashed_circle_painter.dart';


class PowerSwitchButton extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color onColor;
  final Color offColor;
  final Color backgroundColor;
  final ValueChanged<bool> onToggle;

  PowerSwitchButton({
    required this.size,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.onColor,
    required this.offColor,
    required this.backgroundColor,
    required this.onToggle,
  });

  @override
  _PowerSwitchButtonState createState() => _PowerSwitchButtonState();
}

class _PowerSwitchButtonState extends State<PowerSwitchButton> with SingleTickerProviderStateMixin {
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
                  color: Colors.black,
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
