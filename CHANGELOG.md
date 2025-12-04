# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-12-04

### Added
- Android native platform support via `FlutterAccessibilityHelperPlugin` for accurate accessibility detection
- `AccessibilityPlatformService` for platform channel communication with native Android/iOS APIs
- `getAccessibilityDetails()` method in `AccessibilityHelper` for comprehensive accessibility feature detection
- Native Android detection for:
  - Bold text (using `fontWeightAdjustment` on Android 12+)
  - Invert colors
  - High contrast mode
  - Reduce motion / disable animations
  - Font scale and text size detection
  - TalkBack and screen reader detection
- Enhanced example app with detailed test results dialogs showing:
  - What tests were run
  - Individual test results with pass/fail status
  - Detailed explanations of each test
- Improved focus management section in example app with multiple focus nodes
- Screen reader optimizer section in example app
- Comprehensive accessibility status dialog with feature details and detection source indicators
- Enhanced testing features with detailed dialogs for:
  - Accessibility tests (context validation, semantics support, features detection, issues check)
  - Semantics tests (valid label/hint, empty label/hint detection)
  - Focus order validation (empty list, valid nodes, duplicate detection, type validation)

### Changed
- `isAccessibilityEnabled` now properly checks Flutter's `AccessibilityFeatures` API
- `validateAccessibility()` now includes context validation and better error handling
- `AccessibilityTesting.validateFocusOrder()` now properly validates focus nodes (checks for empty lists, duplicates, and invalid types)
- `AccessibilityTesting.checkContrastRatio()` now implements WCAG AA standard contrast ratio calculation (4.5:1 for normal text)
- `AccessibilityTesting.hasProperSemantics()` now properly validates Semantics widgets and interactive widgets
- `ScreenReaderOptimizer.optimizeForScreenReader()` now removes excessive punctuation and normalizes whitespace
- Example app testing features now show detailed dialogs instead of simple snackbars
- Example app UI improved with cards, better layout, and scrollable content
- Code formatting improvements (arrow functions, better organization)

### Fixed
- **Bold text detection on Android**: Fixed incorrect detection by using `fontWeightAdjustment` API on Android 12+ (API 31+). For older Android versions, now properly falls back to Flutter's `AccessibilityFeatures.boldText` instead of unreliable heuristics
- **API Compatibility**: Reverted to deprecated `SemanticsService.announce()` method as `sendAnnouncement()` is not yet available in current Flutter SDK (3.38.3). The deprecated method remains the working API and will be updated when `sendAnnouncement()` becomes available in a future Flutter release
- Fixed async context usage in example app (`use_build_context_synchronously` lint warning)
- Fixed unnecessary braces in string interpolation
- Improved error handling in accessibility detection methods
- Better null safety and type checking in testing utilities

### Removed
- Removed weak heuristic-based bold text detection that was unreliable
- Removed placeholder implementations in testing utilities

### Security
- N/A

## [0.0.1] - 2024-12-19

### Added
- Initial release of flutter_accessibility_helper
- Core accessibility utilities for Flutter applications
- Focus management and navigation helpers
- Screen reader optimization tools
- Comprehensive accessibility testing framework
- Documentation and examples
- Unit tests and integration tests
- Pana analysis configuration for full score compliance
- Flutter and Dart analysis setup
- CI/CD pipeline configuration

---

## Version History

- **0.1.0** - Major feature update with Android native support, enhanced testing, and bug fixes
- **0.0.1** - Initial release with core accessibility features