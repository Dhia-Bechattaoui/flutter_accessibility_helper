/// Flutter Accessibility Helper
///
/// A comprehensive package providing screen reader optimization, focus management,
/// and accessibility testing tools for Flutter applications.
///
/// This package helps developers create more accessible Flutter applications
/// by providing utilities for:
/// - Screen reader optimization
/// - Focus management and navigation
/// - Accessibility testing and validation
/// - ARIA-like semantics for Flutter widgets
///
/// Example usage:
/// ```dart
/// import 'package:flutter_accessibility_helper/flutter_accessibility_helper.dart';
///
/// // Use accessibility helpers in your widgets
/// AccessibilityHelper.announceToScreenReader('New content loaded');
/// ```
library;

// Core accessibility utilities
export 'src/accessibility_helper.dart';
export 'src/accessibility_testing.dart';
export 'src/focus_manager.dart' show AccessibilityFocusManager;
export 'src/screen_reader_optimizer.dart';

// Constants and enums
export 'src/constants/accessibility_constants.dart';
export 'src/enums/accessibility_enums.dart';

// Exceptions
export 'src/exceptions/accessibility_exceptions.dart';

// Widget extensions and mixins
export 'src/mixins/accessibility_mixins.dart';
export 'src/widgets/accessibility_widgets.dart';

// Testing utilities
export 'src/testing/accessibility_test_utils.dart';
export 'src/testing/semantics_tester.dart';
