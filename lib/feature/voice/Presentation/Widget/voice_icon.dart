import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VoiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPressed;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  VoiceIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.isPressed,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: isPressed ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPressed ? Colors.black : Colors.white,
              size: 32,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white),
        )
      ],
    );
  }
}
