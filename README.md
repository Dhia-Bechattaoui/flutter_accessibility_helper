# Flutter Accessibility Helper

A comprehensive Flutter package providing screen reader optimization, focus management, and accessibility testing tools to help developers create more accessible Flutter applications.

## Features

- **Screen Reader Optimization**: Tools to optimize content for screen readers
- **Focus Management**: Comprehensive focus management utilities for keyboard navigation
- **Accessibility Testing**: Built-in testing tools for accessibility compliance
- **Widget Extensions**: Pre-built accessible widgets and extensions
- **Semantic Support**: ARIA-like semantics for Flutter widgets
- **Testing Utilities**: Comprehensive testing framework for accessibility features

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_accessibility_helper: ^0.0.1
```

### Usage

```dart
import 'package:flutter_accessibility_helper/flutter_accessibility_helper.dart';

// Announce to screen reader
AccessibilityHelper.announceToScreenReader('Form submitted successfully');

// Create accessible button
AccessibilityWidgets.accessibleButton(
  label: 'Submit Form',
  onPressed: () => submitForm(),
  hint: 'Double tap to submit the form',
);

// Manage focus
final focusNode = FocusManager.createFocusNode();
FocusManager.requestFocus(context, focusNode);
```

## Core Components

### AccessibilityHelper

The main utility class providing core accessibility functions:

```dart
// Announce messages to screen readers
AccessibilityHelper.announceToScreenReader('New content loaded');

// Check accessibility status
if (AccessibilityHelper.isAccessibilityEnabled) {
  // Provide enhanced features
}

// Validate accessibility compliance
final issues = AccessibilityHelper.validateAccessibility(context);
```

### FocusManager

Comprehensive focus management utilities:

```dart
// Create and manage focus nodes
final focusNode = FocusManager.createFocusNode();

// Navigate focus
FocusManager.nextFocus(context);
FocusManager.previousFocus(context);

// Check focus status
if (FocusManager.hasFocus(focusNode)) {
  // Handle focused state
}
```

### ScreenReaderOptimizer

Optimize content for screen readers:

```dart
// Optimize text for speech
final optimizedText = ScreenReaderOptimizer.optimizeForScreenReader(
  'Hello, World!'
);

// Create semantic labels
final label = ScreenReaderOptimizer.createSemanticLabel('Press', 'button');
```

### AccessibilityWidgets

Pre-built accessible widgets:

```dart
// Accessible button with proper semantics
AccessibilityWidgets.accessibleButton(
  label: 'Save',
  onPressed: saveData,
  hint: 'Double tap to save your changes',
);

// Accessible text with semantic labels
AccessibilityWidgets.accessibleText(
  'Submit',
  semanticsLabel: 'Submit button for the contact form',
);
```

## Testing

The package includes comprehensive testing utilities:

```dart
// Test accessibility compliance
final issues = AccessibilityTesting.validateAccessibility(context);

// Test semantics
final isValid = SemanticsTester.testSemantics('Label', 'Hint');

// Test focus order
final focusValid = AccessibilityTesting.validateFocusOrder(widgets);
```

## Accessibility Best Practices

This package helps implement several accessibility best practices:

1. **Semantic Labels**: Provide meaningful labels for all interactive elements
2. **Focus Management**: Ensure logical tab order and proper focus indicators
3. **Screen Reader Support**: Optimize content for screen reader announcements
4. **Testing**: Comprehensive testing for accessibility compliance
5. **Documentation**: Clear documentation and examples for all features

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please:

1. Check the [documentation](https://github.com/Dhia-Bechattaoui/flutter_accessibility_helper#readme)
2. Search [existing issues](https://github.com/Dhia-Bechattaoui/flutter_accessibility_helper/issues)
3. Create a [new issue](https://github.com/Dhia-Bechattaoui/flutter_accessibility_helper/issues/new)

## Version History

See [CHANGELOG.md](CHANGELOG.md) for a complete version history.

---

**Note**: This package is designed to achieve a full Pana score of 160/160 and follows Flutter and Dart best practices for accessibility.
