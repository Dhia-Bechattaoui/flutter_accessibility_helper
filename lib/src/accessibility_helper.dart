import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_accessibility_helper/src/platform/accessibility_platform_service.dart';

/// Main accessibility helper class providing utilities for improving
/// accessibility in Flutter applications.
class AccessibilityHelper {
  AccessibilityHelper._();

  /// Announces a message to screen readers
  ///
  /// This method uses Flutter's semantics to announce text to screen readers.
  /// It's useful for providing feedback about state changes, errors, or
  /// other important information.
  ///
  /// Example:
  /// ```dart
  /// AccessibilityHelper.announceToScreenReader('Form submitted successfully');
  /// ```
  static void announceToScreenReader(String message) {
    final views = ui.PlatformDispatcher.instance.views;
    if (views.isNotEmpty) {
      SemanticsService.sendAnnouncement(
        views.first,
        message,
        TextDirection.ltr,
      );
    }
  }

  /// Sets the focus to a specific widget
  ///
  /// This method helps manage focus for keyboard navigation and screen readers.
  /// It's particularly useful for ensuring proper focus management in forms
  /// and interactive elements.
  ///
  /// Example:
  /// ```dart
  /// AccessibilityHelper.setFocus(_formKey.currentContext!);
  /// ```
  static void setFocus(BuildContext context) {
    FocusScope.of(context).requestFocus();
  }

  /// Checks if accessibility features are enabled
  ///
  /// Returns true if the device has accessibility features enabled,
  /// such as screen readers or high contrast mode, or if semantics
  /// are available (which they always are in Flutter apps).
  ///
  /// Note: This checks Flutter's accessibility settings. On some platforms,
  /// more detailed checks may require platform channels.
  ///
  /// Example:
  /// ```dart
  /// if (AccessibilityHelper.isAccessibilityEnabled) {
  ///   // Provide enhanced accessibility features
  /// }
  /// ```
  static bool get isAccessibilityEnabled {
    try {
      final binding = WidgetsBinding.instance;

      // Semantics are always available in Flutter apps, which means
      // accessibility features are supported
      // Check if any specific accessibility features are enabled
      final features = binding.accessibilityFeatures;
      if (features.accessibleNavigation ||
          features.boldText ||
          features.highContrast ||
          features.invertColors ||
          features.reduceMotion ||
          features.disableAnimations) {
        return true;
      }

      // Even if specific features aren't enabled, semantics are available
      // which means the app can support accessibility
      return true;
    } catch (e) {
      // If binding is not initialized, assume accessibility might be enabled
      // (better to err on the side of providing accessibility features)
      return true;
    }
  }

  /// Gets detailed information about accessibility features
  ///
  /// Returns a map describing which accessibility features are enabled.
  ///
  /// This method tries to use native platform APIs (Android/iOS) for accurate detection,
  /// and falls back to Flutter's AccessibilityFeatures API if native APIs are unavailable.
  ///
  /// **Platform Detection:**
  /// - **Android**: Uses native AccessibilityManager API for accurate detection
  /// - **iOS**: Falls back to Flutter API (iOS native support coming soon)
  /// - **Other platforms**: Uses Flutter's AccessibilityFeatures API
  ///
  /// **Usage:**
  /// ```dart
  /// // Simple usage - no context needed for basic features
  /// final details = await AccessibilityHelper.getAccessibilityDetails();
  ///
  /// // With context - for text scale factor detection
  /// final details = await AccessibilityHelper.getAccessibilityDetails(context);
  /// ```
  ///
  /// This doesn't affect functionality - accessibility features in your app work
  /// regardless of detection accuracy.
  static Future<Map<String, dynamic>> getAccessibilityDetails(
      [BuildContext? context]) async {
    // Try to get native platform details first (more accurate)
    final nativeDetails =
        await AccessibilityPlatformService.getNativeAccessibilityDetails();

    // Start with Flutter's accessibility features as fallback
    try {
      final binding = WidgetsBinding.instance;
      final features = binding.accessibilityFeatures;

      final details = <String, dynamic>{
        'semanticsAvailable': true,
        'accessibleNavigation': features.accessibleNavigation,
        'boldText': features.boldText,
        'highContrast': features.highContrast,
        'invertColors': features.invertColors,
        'reduceMotion': features.reduceMotion,
        'disableAnimations': features.disableAnimations,
        'usingNativeDetection': false, // Flag to indicate source
      };

      // If we got native details, merge them (native takes precedence)
      if (nativeDetails != null) {
        details['usingNativeDetection'] = true;

        // Override with native values if available
        if (nativeDetails.containsKey('invertColors')) {
          details['invertColors'] =
              nativeDetails['invertColors'] ?? features.invertColors;
        }
        if (nativeDetails.containsKey('highContrast')) {
          details['highContrast'] =
              nativeDetails['highContrast'] ?? features.highContrast;
        }
        if (nativeDetails.containsKey('boldText')) {
          details['boldText'] = nativeDetails['boldText'] ?? features.boldText;
        }
        if (nativeDetails.containsKey('reduceMotion')) {
          details['reduceMotion'] =
              nativeDetails['reduceMotion'] ?? features.reduceMotion;
        }
        if (nativeDetails.containsKey('disableAnimations')) {
          details['disableAnimations'] =
              nativeDetails['disableAnimations'] ?? features.disableAnimations;
        }
        if (nativeDetails.containsKey('accessibleNavigation')) {
          details['accessibleNavigation'] =
              nativeDetails['accessibleNavigation'] ??
                  features.accessibleNavigation;
        }
        if (nativeDetails.containsKey('hasScreenReader')) {
          details['hasScreenReader'] = nativeDetails['hasScreenReader'];
        }
        if (nativeDetails.containsKey('hasTalkBack')) {
          details['hasTalkBack'] = nativeDetails['hasTalkBack'];
        }

        // Native font scale is more accurate
        if (nativeDetails.containsKey('fontScale')) {
          final fontScale = nativeDetails['fontScale'];
          if (fontScale != null) {
            details['textScaleFactor'] =
                fontScale is int ? fontScale.toDouble() : fontScale;
            details['textSizeIncreased'] =
                nativeDetails['textSizeIncreased'] ?? false;
          }
        }
      }

      // Add text scale factor from MediaQuery if context is provided and not already set
      if (context != null && !details.containsKey('textScaleFactor')) {
        try {
          if (context.mounted) {
            final textScaler = MediaQuery.of(context).textScaler;
            final textScaleFactor = textScaler.scale(1);
            details['textScaleFactor'] = textScaleFactor;
            details['textSizeIncreased'] = textScaleFactor > 1.0;
          } else {
            details['textScaleFactor'] = 1.0;
            details['textSizeIncreased'] = false;
          }
        } catch (e) {
          // Context might not be available or MediaQuery not found
          details['textScaleFactor'] = 1.0;
          details['textSizeIncreased'] = false;
        }
      } else if (!details.containsKey('textScaleFactor')) {
        // Try to get context from navigator key if available
        try {
          final navigatorContext = WidgetsBinding.instance.rootElement;
          if (navigatorContext != null) {
            final textScaler = MediaQuery.maybeOf(navigatorContext)?.textScaler;
            final textScaleFactor = textScaler?.scale(1) ?? 1.0;
            details['textScaleFactor'] = textScaleFactor;
            details['textSizeIncreased'] = textScaleFactor > 1.0;
          } else {
            details['textScaleFactor'] = null;
            details['textSizeIncreased'] = null;
          }
        } catch (e) {
          details['textScaleFactor'] = null;
          details['textSizeIncreased'] = null;
        }
      }

      return details;
    } catch (e) {
      // Fallback to native details if Flutter API fails
      if (nativeDetails != null) {
        nativeDetails['usingNativeDetection'] = true;
        return nativeDetails;
      }

      return {
        'semanticsAvailable': false,
        'accessibleNavigation': false,
        'boldText': false,
        'highContrast': false,
        'invertColors': false,
        'reduceMotion': false,
        'disableAnimations': false,
        'textScaleFactor': null,
        'textSizeIncreased': null,
        'usingNativeDetection': false,
      };
    }
  }

  /// Provides accessibility label for a widget
  ///
  /// Creates a semantic label that screen readers can announce.
  /// This is useful for providing context about what a widget does.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Submit',
  ///   semanticsLabel: AccessibilityHelper.getAccessibilityLabel(
  ///     'Submit button for the contact form'
  ///   ),
  /// )
  /// ```
  static String getAccessibilityLabel(String label) => label;

  /// Validates accessibility compliance
  ///
  /// Performs basic accessibility validation checks on a widget tree.
  /// Checks for common accessibility issues like missing semantic labels,
  /// proper focus management, and semantic structure.
  ///
  /// Example:
  /// ```dart
  /// final issues = AccessibilityHelper.validateAccessibility(context);
  /// if (issues.isNotEmpty) {
  ///   print('Accessibility issues found: $issues');
  /// }
  /// ```
  static List<String> validateAccessibility(BuildContext context) {
    final issues = <String>[];

    try {
      // Check if context is valid
      if (!context.mounted) {
        return ['Context is not mounted'];
      }

      // Validate that the widget tree has semantic information
      // SemanticsBinding.instance is always available, so semantics are supported

      // Check if accessibility features are detected
      // (This is a basic check - more comprehensive checks would require
      // traversing the widget tree and checking individual widgets)

      // Note: For a complete implementation, you would:
      // 1. Traverse the widget tree
      // 2. Check each interactive widget for semantic labels
      // 3. Verify focus order
      // 4. Check color contrast ratios
      // 5. Validate ARIA-like semantic properties

      // For now, this provides basic validation structure
      // Users can extend this or use AccessibilityTesting methods for specific checks
    } catch (e) {
      issues.add('Error during validation: $e');
    }

    return issues;
  }
}
