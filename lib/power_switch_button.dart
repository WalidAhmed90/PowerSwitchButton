library power_switch_button;

import 'package:flutter/material.dart';
import 'dashed_circle_painter.dart';
import 'enum.dart';

typedef LoadingCallback = Future<bool> Function();

/// A customizable switch button with animated on/off states and dashed border.
class PowerSwitchButton extends StatefulWidget {
  /// The size of the switch button.
  final double size;

  /// The stroke width of the dashed border.
  final double strokeWidth;

  /// The width of each dash in the dashed border.
  final double dashWidth;

  /// The space between each dash in the dashed border.
  final double dashSpace;

  /// The color of the switch when it is in the 'on' position.
  final Color onColor;

  /// The color of the switch when it is in the 'off' position.
  final Color offColor;

  /// The background color of the switch.
  final Color backgroundColor;

  /// The color of the power icon.
  final Color iconColor;

  /// The custom icon for the switch.
  final IconData? customIcon;

  /// The label text to display inside the switch.
  final String? label;

  /// Whether the switch is disabled.
  final bool disabled;

  /// The gradient colors for the 'on' state.
  final Gradient? onGradient;

  /// The gradient colors for the 'off' state.
  final Gradient? offGradient;

  /// The duration of the toggle animation.
  final Duration animationDuration;

  /// The curve of the toggle animation.
  final Curve animationCurve;

  /// The shape of the switch button.
  final Shape shape;

  /// The border radius for the square shape. Optional.
  final double? borderRadius;

  /// Callback that gets called when the switch is toggled.
  final ValueChanged<bool> onToggle;

  /// Callback function for managing the loading state.
  final Future<bool> Function()? loadingCallback;

  /// The text to display during the loading state.
  final String? loadingText;

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
    this.customIcon,
    this.label,
    this.disabled = false,
    this.onGradient,
    this.offGradient,
    this.shape = Shape.CIRCLE, // Default shape
    this.borderRadius, // Optional border radius
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.loadingCallback,
    this.loadingText, // Default is not loading
  });

  @override
  _PowerSwitchButtonState createState() => _PowerSwitchButtonState();
}

class _PowerSwitchButtonState extends State<PowerSwitchButton>
    with TickerProviderStateMixin {
  bool isOn = false;
  bool isLoading = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleAnimationForSquare;
  late Animation<double> _rotationAnimation;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    /// Initialize the scale controller and animation for button press effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );

    /// Initialize the rotation controller and animation for loading state
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOutCirc),
    );

    /// Initialize scale animation for square shapes
    _scaleAnimationForSquare = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
          parent: _rotationController, curve: widget.animationCurve),
    );
  }

  /// Toggles the switch state and calls the onToggle callback.
  void _toggleSwitch() async {
    if (!widget.disabled && !isLoading) {
      setState(() {
        isLoading = true;
      });

      if (widget.loadingCallback != null) {
        bool success = await widget.loadingCallback!();
        setState(() {
          isLoading = false;
          isOn = success ? !isOn : isOn;
          widget.onToggle(isOn);
        });
      } else {
        setState(() {
          isLoading = false;
          isOn = !isOn;
          widget.onToggle(isOn);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final outerCircleSize = widget.size;
    final middleCircleSize = widget.size * 0.8;
    final innerCircleSize = widget.size * 0.6;

    return Stack(
      alignment: Alignment.center,
      children: [
        /// Outer circle or square with background color
        Container(
          width: outerCircleSize,
          height: outerCircleSize,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            shape: widget.shape == Shape.CIRCLE
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius:
                widget.shape == Shape.SQUARE && widget.borderRadius != null
                    ? BorderRadius.circular(widget.borderRadius!)
                    : null,
          ),
        ),

        /// Loading animation (rotating dashed circle or scaling dashed square)
        if (isLoading)
          if (widget.shape == Shape.CIRCLE)
            RotationTransition(
              turns: _rotationAnimation,
              child: CustomPaint(
                size: Size(middleCircleSize, middleCircleSize),
                painter: DashedShapePainter(
                  strokeWidth: widget.strokeWidth,
                  dashWidth1: widget.dashWidth,
                  dashSpace1: widget.dashSpace,
                  strokeColor: isOn ? widget.onColor : widget.offColor,
                  shape: widget.shape,
                  borderRadius: widget.borderRadius,
                ),
              ),
            )
          else
            ScaleTransition(
              scale: _scaleAnimationForSquare,
              child: CustomPaint(
                size: Size(middleCircleSize, middleCircleSize),
                painter: DashedShapePainter(
                  strokeWidth:
                      _scaleAnimationForSquare.value * widget.strokeWidth +
                          (_scaleAnimationForSquare.value),
                  dashWidth1: widget.dashWidth,
                  dashSpace1: widget.dashSpace,
                  strokeColor: isOn ? widget.onColor : widget.offColor,
                  shape: widget.shape,
                  borderRadius: widget.borderRadius,
                ),
              ),
            )

        /// Normal dashed border (circle or square)
        else
          CustomPaint(
            size: Size(middleCircleSize, middleCircleSize),
            painter: DashedShapePainter(
              strokeWidth: widget.strokeWidth,
              dashWidth1: widget.dashWidth,
              dashSpace1: widget.dashSpace,
              strokeColor: isOn ? widget.onColor : widget.offColor,
              shape: widget.shape,
              borderRadius: widget.borderRadius,
            ),
          ),

        /// Inner circle or square with icon and label
        GestureDetector(
          onTapDown: (_) {
            _controller.forward();
          },
          onTapUp: (_) {
            _controller.reverse();
            _toggleSwitch();
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              width: innerCircleSize,
              height: innerCircleSize,
              decoration: BoxDecoration(
                shape: widget.shape == Shape.CIRCLE
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius:
                    widget.shape == Shape.SQUARE && widget.borderRadius != null
                        ? BorderRadius.circular(widget.borderRadius!)
                        : null,
                gradient: isOn ? widget.onGradient : widget.offGradient,
                color: widget.disabled
                    ? Colors.grey.withOpacity(0.5)
                    : isOn
                        ? widget.onColor
                        : widget.offColor,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.customIcon != null)
                      Icon(
                        widget.customIcon,
                        size: innerCircleSize * 0.5,
                        color: widget.iconColor,
                      )
                    else
                      Icon(
                        Icons.power_settings_new,
                        size: innerCircleSize * 0.5,
                        color: widget.iconColor,
                      ),
                    if (widget.label != null)
                      Text(
                        isLoading
                            ? (widget.loadingText != null
                                ? widget.loadingText!
                                : "Loading..")
                            : widget.label!,
                        style: TextStyle(
                          color: widget.iconColor,
                          fontSize: innerCircleSize * 0.1,
                        ),
                      ),
                  ],
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
    _rotationController.dispose();
    super.dispose();
  }
}
