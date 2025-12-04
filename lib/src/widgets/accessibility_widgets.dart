import 'package:flutter/material.dart';

/// Accessibility widget extensions
class AccessibilityWidgets {
  AccessibilityWidgets._();

  /// Creates an accessible button with proper semantics
  static Widget accessibleButton({
    required String label,
    required VoidCallback onPressed,
    String? hint,
  }) =>
      Semantics(
        label: label,
        hint: hint,
        button: true,
        enabled: true,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      );

  /// Creates accessible text with proper semantics
  static Widget accessibleText(
    String text, {
    String? semanticsLabel,
    TextStyle? style,
  }) =>
      Semantics(
        label: semanticsLabel ?? text,
        child: Text(
          text,
          style: style,
        ),
      );
}
