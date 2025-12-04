import 'package:flutter/services.dart';

/// Platform service for accessing native accessibility features
///
/// This service provides access to platform-specific accessibility detection
/// using native APIs for more accurate results.
class AccessibilityPlatformService {
  /// Private constructor to prevent instantiation
  ///
  /// This class is meant to be used statically only.
  AccessibilityPlatformService._();
  static const MethodChannel _channel =
      MethodChannel('flutter_accessibility_helper');

  /// Gets accessibility details from the native platform
  ///
  /// Returns a map with accessibility features detected by the native platform.
  /// Returns null if the platform channel is not available or fails.
  static Future<Map<String, dynamic>?> getNativeAccessibilityDetails() async {
    try {
      final result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'getAccessibilityDetails',
      );

      if (result == null) {
        return null;
      }

      // Convert Map<Object?, Object?> to Map<String, dynamic>
      return result.map((key, value) => MapEntry(
            key.toString(),
            value,
          ));
    } on PlatformException {
      // Platform channel not available or method not implemented
      return null;
    } catch (_) {
      // Other errors
      return null;
    }
  }

  /// Checks if platform channel is available
  static Future<bool> isPlatformChannelAvailable() async {
    try {
      await _channel.invokeMethod('getAccessibilityDetails');
      return true;
    } catch (e) {
      return false;
    }
  }
}
