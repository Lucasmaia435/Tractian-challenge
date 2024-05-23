import 'package:flutter/material.dart';
import 'package:tractian_test/core/colors.dart';

class AssetsFilterButton extends StatelessWidget {
  const AssetsFilterButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.icon,
    required this.isActive,
  });

  final void Function()? onPressed;
  final String label;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: isActive ? TractianColors.primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: isActive
                ? TractianColors.primaryColor
                : const Color(0xFFD8DFE6),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : TractianColors.iconLabelColor,
        ),
      ),
      icon: Icon(
        icon,
        color: isActive ? Colors.white : TractianColors.iconLabelColor,
      ),
    );
  }
}
