/// Utilities for testing semantics
class SemanticsTester {
  SemanticsTester._();

  /// Tests if semantics are properly configured
  static bool testSemantics(String label, String hint) {
    return label.isNotEmpty && hint.isNotEmpty;
  }

  /// Validates semantic structure
  static bool validateSemanticStructure(List<String> elements) {
    return elements.isNotEmpty;
  }
}
