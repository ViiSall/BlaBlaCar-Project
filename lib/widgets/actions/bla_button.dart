import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

// Blablacar Buttons

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const BlaButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.type = ButtonType.primary,
      this.icon});

  @override
  Widget build(BuildContext context) {
    // Compute rendering
    Color backgroundColor =
        type == ButtonType.primary ? BlaColors.primary : BlaColors.white;

    BorderSide border = type == ButtonType.primary
        ? BorderSide.none
        : BorderSide(color: BlaColors.greyLight, width: 2);

    Color textColor =
        type == ButtonType.primary ? BlaColors.white : BlaColors.primary;

    Color iconColor =
        type == ButtonType.primary ? BlaColors.white : BlaColors.primary;

    // Create button icon
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(
        icon,
        size: 20,
        color: iconColor,
      ));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    // Create button text
    Text buttonText =
        Text(text, style: BlaTextStyles.button.copyWith(color: textColor));

    children.add(buttonText);

    // Render button
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          side: border,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
