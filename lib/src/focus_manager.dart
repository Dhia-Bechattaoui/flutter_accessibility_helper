import 'package:flutter/material.dart';

/// Manages focus for accessibility and keyboard navigation
class AccessibilityFocusManager {
  AccessibilityFocusManager._();

  /// Creates a new focus node
  static FocusNode createFocusNode() => FocusNode();

  /// Requests focus for a specific widget
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  /// Moves focus to the next focusable widget
  static void nextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Moves focus to the previous focusable widget
  static void previousFocus(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  /// Checks if a widget currently has focus
  static bool hasFocus(FocusNode focusNode) => focusNode.hasFocus;

  /// Unfocuses the current focus
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
