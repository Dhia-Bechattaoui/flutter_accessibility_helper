/// Utilities for testing accessibility features
class AccessibilityTestUtils {
  AccessibilityTestUtils._();

  /// Tests if a widget has proper accessibility labels
  static bool hasAccessibilityLabels(String label) => label.isNotEmpty;

  /// Validates accessibility hints
  static bool validateAccessibilityHints(String hint) => hint.isNotEmpty;
}
