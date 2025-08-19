/// Exceptions for accessibility features
class AccessibilityException implements Exception {
  /// Creates an accessibility exception
  const AccessibilityException(this.message);

  /// The error message
  final String message;

  @override
  String toString() => 'AccessibilityException: $message';
}

/// Exception thrown when accessibility validation fails
class AccessibilityValidationException extends AccessibilityException {
  /// Creates an accessibility validation exception
  const AccessibilityValidationException(super.message);
}

/// Exception thrown when focus management fails
class FocusManagementException extends AccessibilityException {
  /// Creates a focus management exception
  const FocusManagementException(super.message);
}
