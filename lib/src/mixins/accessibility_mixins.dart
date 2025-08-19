/// Mixin for adding accessibility features to widgets
mixin AccessibilityMixin {
  /// Adds accessibility label to a widget
  String get accessibilityLabel => '';

  /// Adds accessibility hint to a widget
  String get accessibilityHint => '';

  /// Checks if accessibility is enabled
  bool get isAccessibilityEnabled => true;
}
