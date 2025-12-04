/// Optimizes content for screen readers
class ScreenReaderOptimizer {
  ScreenReaderOptimizer._();

  /// Optimizes text for screen reader announcement
  ///
  /// This method improves text readability for screen readers by:
  /// - Removing excessive punctuation (multiple exclamation marks, question marks, etc.)
  /// - Normalizing whitespace
  /// - Trimming leading and trailing spaces
  ///
  /// Example:
  /// ```dart
  /// final optimized = ScreenReaderOptimizer.optimizeForScreenReader('Hello, World!!!');
  /// // Returns: 'Hello, World!'
  /// ```
  static String optimizeForScreenReader(String text) {
    if (text.isEmpty) return text;

    // Trim leading and trailing whitespace
    String optimized = text.trim();

    // Remove excessive punctuation (more than one of the same type)
    // Replace multiple exclamation marks with a single one
    optimized = optimized.replaceAll(RegExp('!{2,}'), '!');
    // Replace multiple question marks with a single one
    optimized = optimized.replaceAll(RegExp(r'\?{2,}'), '?');
    // Replace multiple periods with a single one (but preserve ellipsis)
    optimized = optimized.replaceAll(RegExp(r'\.{4,}'), '...');
    // Replace multiple commas with a single one
    optimized = optimized.replaceAll(RegExp(',{2,}'), ',');
    // Replace multiple colons with a single one
    optimized = optimized.replaceAll(RegExp(':{2,}'), ':');
    // Replace multiple semicolons with a single one
    optimized = optimized.replaceAll(RegExp(';{2,}'), ';');

    // Normalize multiple spaces to single space
    optimized = optimized.replaceAll(RegExp(r'\s+'), ' ');

    // Trim again after normalization
    return optimized.trim();
  }

  /// Provides alternative text for images
  static String getImageDescription(String description) =>
      description.isEmpty ? 'Image' : description;

  /// Creates semantic labels for interactive elements
  static String createSemanticLabel(String action, String target) =>
      '$action $target';
}
