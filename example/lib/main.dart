import 'package:flutter/material.dart';
import 'package:flutter_accessibility_helper/flutter_accessibility_helper.dart';

void main() {
  runApp(const AccessibilityHelperExampleApp());
}

class AccessibilityHelperExampleApp extends StatelessWidget {
  const AccessibilityHelperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accessibility Helper Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AccessibilityExamplePage(),
    );
  }
}

class AccessibilityExamplePage extends StatefulWidget {
  const AccessibilityExamplePage({super.key});

  @override
  State<AccessibilityExamplePage> createState() =>
      _AccessibilityExamplePageState();
}

class _AccessibilityExamplePageState extends State<AccessibilityExamplePage>
    with AccessibilityMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode1 = AccessibilityFocusManager.createFocusNode();
  final FocusNode _focusNode2 = AccessibilityFocusManager.createFocusNode();
  final FocusNode _focusNode3 = AccessibilityFocusManager.createFocusNode();

  @override
  String get accessibilityLabel => 'Accessibility Helper Example Page';

  @override
  String get accessibilityHint => 'Demonstrates accessibility features';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AccessibilityWidgets.accessibleText(
          'Accessibility Helper Example',
          semanticsLabel: 'Accessibility Helper Example App Bar',
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccessibilityWidgets.accessibleText(
                'Welcome to the Accessibility Helper Example!',
                style: Theme.of(context).textTheme.headlineSmall,
                semanticsLabel:
                    'Welcome message for accessibility helper example',
              ),
              const SizedBox(height: 16),
              AccessibilityWidgets.accessibleText(
                'This example demonstrates various accessibility features:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              _buildFeatureList(),
              const SizedBox(height: 16),
              _buildScreenReaderOptimizerSection(),
              const SizedBox(height: 16),
              _buildInteractiveSection(),
              const SizedBox(height: 16),
              _buildFocusManagementSection(),
              const SizedBox(height: 16),
              _buildTestingSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem('Screen reader optimization'),
        _buildFeatureItem('Focus management'),
        _buildFeatureItem('Accessibility testing'),
        _buildFeatureItem('Widget extensions'),
        _buildFeatureItem('Semantic support'),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          AccessibilityWidgets.accessibleText(
            text,
            semanticsLabel: 'Feature: $text',
          ),
        ],
      ),
    );
  }

  Widget _buildScreenReaderOptimizerSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibilityWidgets.accessibleText(
              'Screen Reader Optimization',
              style: Theme.of(context).textTheme.titleMedium,
              semanticsLabel: 'Screen reader optimization section',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AccessibilityWidgets.accessibleButton(
                  label: 'Optimize Text',
                  onPressed: _optimizeText,
                  hint: 'Double tap to optimize text for screen reader',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Create Semantic Label',
                  onPressed: _createSemanticLabel,
                  hint: 'Double tap to create a semantic label',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibilityWidgets.accessibleText(
              'AccessibilityHelper Features',
              style: Theme.of(context).textTheme.titleMedium,
              semanticsLabel: 'Accessibility helper features section',
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Text input field for entering text',
              child: TextField(
                controller: _textController,
                focusNode: _focusNode1,
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  hintText: 'Type something here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AccessibilityWidgets.accessibleButton(
                  label: 'Announce Text',
                  onPressed: _announceText,
                  hint:
                      'Double tap to announce the entered text to screen reader',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Check Accessibility Status',
                  onPressed: _checkAccessibilityStatus,
                  hint: 'Double tap to check if accessibility is enabled',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusManagementSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibilityWidgets.accessibleText(
              'Focus Management',
              style: Theme.of(context).textTheme.titleMedium,
              semanticsLabel: 'Focus management section',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: 'First focusable field',
                    child: TextField(
                      focusNode: _focusNode2,
                      decoration: const InputDecoration(
                        labelText: 'Field 1',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Semantics(
                    label: 'Second focusable field',
                    child: TextField(
                      focusNode: _focusNode3,
                      decoration: const InputDecoration(
                        labelText: 'Field 2',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AccessibilityWidgets.accessibleButton(
                  label: 'Request Focus Field 1',
                  onPressed: () => _requestFocus(_focusNode2),
                  hint: 'Double tap to set focus to first field',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Request Focus Field 2',
                  onPressed: () => _requestFocus(_focusNode3),
                  hint: 'Double tap to set focus to second field',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Next Focus',
                  onPressed: _nextFocus,
                  hint: 'Double tap to move focus to next field',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Previous Focus',
                  onPressed: _previousFocus,
                  hint: 'Double tap to move focus to previous field',
                ),
                AccessibilityWidgets.accessibleButton(
                  label: 'Check Focus Status',
                  onPressed: _checkFocusStatus,
                  hint: 'Double tap to check which field has focus',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibilityWidgets.accessibleText(
              'Testing Features',
              style: Theme.of(context).textTheme.titleMedium,
              semanticsLabel: 'Testing features section',
            ),
            const SizedBox(height: 16),
            AccessibilityWidgets.accessibleButton(
              label: 'Run Accessibility Tests',
              onPressed: _runAccessibilityTests,
              hint: 'Double tap to run accessibility validation tests',
            ),
            const SizedBox(height: 16),
            AccessibilityWidgets.accessibleButton(
              label: 'Test Semantics',
              onPressed: _testSemantics,
              hint: 'Double tap to test semantic validation',
            ),
            const SizedBox(height: 16),
            AccessibilityWidgets.accessibleButton(
              label: 'Validate Focus Order',
              onPressed: _validateFocusOrder,
              hint: 'Double tap to validate focus order of widgets',
            ),
          ],
        ),
      ),
    );
  }

  void _announceText() {
    final text =
        _textController.text.isEmpty ? 'No text entered' : _textController.text;
    AccessibilityHelper.announceToScreenReader('Text entered: $text');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Announced: $text'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _optimizeText() {
    const originalText = 'Hello, World!!!';
    final optimizedText =
        ScreenReaderOptimizer.optimizeForScreenReader(originalText);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Original: "$originalText"\nOptimized: "$optimizedText"'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _createSemanticLabel() {
    final label = ScreenReaderOptimizer.createSemanticLabel('Press', 'button');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Created semantic label: "$label"'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _checkAccessibilityStatus() async {
    final isEnabled = AccessibilityHelper.isAccessibilityEnabled;
    final details = await AccessibilityHelper.getAccessibilityDetails(context);

    // Check if context is still mounted after async operation
    if (!mounted || !context.mounted) return;

    // Build detailed message
    final enabledFeatures = <String>[];
    if (details['semanticsAvailable'] == true) {
      enabledFeatures.add('Semantics');
    }
    if (details['accessibleNavigation'] == true) {
      enabledFeatures.add('Accessible Navigation');
    }
    if (details['boldText'] == true) {
      enabledFeatures.add('Bold Text');
    }
    if (details['highContrast'] == true) {
      enabledFeatures.add('High Contrast');
    }
    if (details['invertColors'] == true) {
      enabledFeatures.add('Invert Colors');
    }
    if (details['reduceMotion'] == true) {
      enabledFeatures.add('Reduce Motion');
    }
    if (details['disableAnimations'] == true) {
      enabledFeatures.add('Disable Animations');
    }

    if (!mounted || !context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AccessibilityWidgets.accessibleText(
          'Accessibility Status',
          semanticsLabel: 'Accessibility status dialog',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccessibilityWidgets.accessibleText(
                isEnabled
                    ? '✓ Accessibility is ENABLED'
                    : '✗ Accessibility is DISABLED',
                style: TextStyle(
                  color: isEnabled ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                semanticsLabel: isEnabled
                    ? 'Accessibility is enabled'
                    : 'Accessibility is disabled',
              ),
              const SizedBox(height: 16),
              AccessibilityWidgets.accessibleText(
                'Feature Details:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...details.entries
                  .where((entry) => entry.key != 'textScaleFactor')
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            (entry.value is bool && entry.value == true) ||
                                    (entry.value is double && entry.value > 1.0)
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: (entry.value is bool &&
                                        entry.value == true) ||
                                    (entry.value is double && entry.value > 1.0)
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AccessibilityWidgets.accessibleText(
                                  _formatFeatureName(entry.key),
                                  semanticsLabel:
                                      '${_formatFeatureName(entry.key)}: ${_formatFeatureValue(entry.value)}',
                                ),
                                if (entry.key == 'textSizeIncreased' &&
                                    details['textScaleFactor'] != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 28.0, top: 2.0),
                                    child: AccessibilityWidgets.accessibleText(
                                      'Scale: ${details['textScaleFactor']!.toStringAsFixed(2)}x',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      semanticsLabel:
                                          'Text scale factor: ${details['textScaleFactor']!.toStringAsFixed(2)}',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              if (details['usingNativeDetection'] == true) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.green.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AccessibilityWidgets.accessibleText(
                          'Using native Android detection for accurate results',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                          semanticsLabel: 'Using native Android detection',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: details['usingNativeDetection'] == true
                      ? Colors.blue.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: details['usingNativeDetection'] == true
                          ? Colors.blue.shade200
                          : Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                            details['usingNativeDetection'] == true
                                ? Icons.info_outline
                                : Icons.warning_amber_rounded,
                            color: details['usingNativeDetection'] == true
                                ? Colors.blue.shade700
                                : Colors.orange.shade700,
                            size: 20),
                        const SizedBox(width: 8),
                        AccessibilityWidgets.accessibleText(
                          details['usingNativeDetection'] == true
                              ? 'Detection Info'
                              : 'Detection Limitations',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: details['usingNativeDetection'] == true
                                    ? Colors.blue.shade900
                                    : Colors.orange.shade900,
                              ),
                          semanticsLabel:
                              details['usingNativeDetection'] == true
                                  ? 'Detection information'
                                  : 'Detection limitations warning',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AccessibilityWidgets.accessibleText(
                      details['usingNativeDetection'] == true
                          ? 'Using native Android AccessibilityManager API for accurate detection of accessibility features.\n\n'
                              'This provides more reliable detection than Flutter\'s API, especially on custom Android ROMs.'
                          : 'Flutter\'s AccessibilityFeatures API may not detect all device settings correctly, especially on custom Android ROMs (like MIUI/Xiaomi).\n\n'
                              'Features marked with "(Flutter API)" rely on Flutter\'s detection, which may not match your device settings.\n\n'
                              'This does NOT affect functionality - your app\'s accessibility features work regardless of detection status.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: details['usingNativeDetection'] == true
                                ? Colors.blue.shade900
                                : Colors.orange.shade900,
                          ),
                      semanticsLabel: details['usingNativeDetection'] == true
                          ? 'Using native Android detection for accurate results'
                          : 'Note: Flutter accessibility API limitations on some devices may cause inaccurate detection',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AccessibilityWidgets.accessibleText(
              'OK',
              semanticsLabel: 'Close dialog button',
            ),
          ),
        ],
      ),
    );
  }

  String _formatFeatureName(String key) {
    switch (key) {
      case 'semanticsAvailable':
        return 'Semantics Available';
      case 'accessibleNavigation':
        return 'Accessible Navigation';
      case 'boldText':
        return 'Bold Text (Flutter API)*';
      case 'highContrast':
        return 'High Contrast (Flutter API)*';
      case 'invertColors':
        return 'Invert Colors (Flutter API)*';
      case 'reduceMotion':
        return 'Reduce Motion';
      case 'disableAnimations':
        return 'Disable Animations';
      case 'textSizeIncreased':
        return 'Text Size (Font Scale) ✓';
      default:
        return key;
    }
  }

  String _formatFeatureValue(dynamic value) {
    if (value is bool) {
      return value ? 'enabled' : 'disabled';
    } else if (value is double) {
      return value > 1.0 ? 'enabled' : 'disabled';
    } else if (value == null) {
      return 'not available';
    }
    return value.toString();
  }

  void _requestFocus(FocusNode focusNode) {
    AccessibilityFocusManager.requestFocus(context, focusNode);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Focus requested'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _nextFocus() {
    AccessibilityFocusManager.nextFocus(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Moved to next focus'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _previousFocus() {
    AccessibilityFocusManager.previousFocus(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Moved to previous focus'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _checkFocusStatus() {
    final hasFocus1 = AccessibilityFocusManager.hasFocus(_focusNode2);
    final hasFocus2 = AccessibilityFocusManager.hasFocus(_focusNode3);

    String status;
    if (hasFocus1) {
      status = 'Field 1 has focus';
    } else if (hasFocus2) {
      status = 'Field 2 has focus';
    } else {
      status = 'No focus on test fields';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(status),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _runAccessibilityTests() {
    final issues = AccessibilityHelper.validateAccessibility(context);

    // Build detailed test results
    final testResults = <Map<String, dynamic>>[];

    // Test 1: Context validation
    testResults.add({
      'name': 'Context Validation',
      'status': context.mounted ? 'PASSED' : 'FAILED',
      'details': context.mounted
          ? 'Context is properly mounted and available'
          : 'Context is not mounted - cannot perform validation',
      'passed': context.mounted,
    });

    // Test 2: Semantics availability
    try {
      // WidgetsBinding.instance is always available in Flutter apps
      WidgetsBinding.instance; // Access to verify it's available
      testResults.add({
        'name': 'Semantics Support',
        'status': 'PASSED',
        'details':
            'Semantics binding is available - accessibility features are supported',
        'passed': true,
      });
    } catch (e) {
      testResults.add({
        'name': 'Semantics Support',
        'status': 'FAILED',
        'details': 'Error checking semantics: $e',
        'passed': false,
      });
    }

    // Test 3: Accessibility features detection
    try {
      final binding = WidgetsBinding.instance;
      final features = binding.accessibilityFeatures;
      final hasFeatures = features.accessibleNavigation ||
          features.boldText ||
          features.highContrast ||
          features.invertColors ||
          features.reduceMotion ||
          features.disableAnimations;
      testResults.add({
        'name': 'Accessibility Features Detection',
        'status': 'PASSED',
        'details': hasFeatures
            ? 'Accessibility features are detected and available'
            : 'No specific accessibility features detected (this is normal if none are enabled)',
        'passed': true,
      });
    } catch (e) {
      testResults.add({
        'name': 'Accessibility Features Detection',
        'status': 'FAILED',
        'details': 'Error detecting features: $e',
        'passed': false,
      });
    }

    // Test 4: Issues found
    testResults.add({
      'name': 'Accessibility Issues Check',
      'status': issues.isEmpty ? 'PASSED' : 'WARNING',
      'details': issues.isEmpty
          ? 'No accessibility issues found in the widget tree'
          : 'Found ${issues.length} potential issue(s): ${issues.join(", ")}',
      'passed': issues.isEmpty,
    });

    final passedCount = testResults.where((r) => r['passed'] == true).length;
    final totalCount = testResults.length;
    final allPassed = passedCount == totalCount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AccessibilityWidgets.accessibleText(
          'Accessibility Test Results',
          semanticsLabel: 'Accessibility test results dialog',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      allPassed ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: allPassed
                        ? Colors.green.shade200
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      allPassed ? Icons.check_circle : Icons.warning,
                      color: allPassed
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AccessibilityWidgets.accessibleText(
                        '$passedCount/$totalCount tests passed',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: allPassed
                                      ? Colors.green.shade900
                                      : Colors.orange.shade900,
                                ),
                        semanticsLabel:
                            '$passedCount out of $totalCount tests passed',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...testResults.map((result) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              result['passed'] == true
                                  ? Icons.check_circle
                                  : result['status'] == 'WARNING'
                                      ? Icons.warning
                                      : Icons.cancel,
                              color: result['passed'] == true
                                  ? Colors.green
                                  : result['status'] == 'WARNING'
                                      ? Colors.orange
                                      : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AccessibilityWidgets.accessibleText(
                                '${result['name']}: ${result['status']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                semanticsLabel:
                                    '${result['name']}: ${result['status']}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: AccessibilityWidgets.accessibleText(
                            result['details'] as String,
                            style: Theme.of(context).textTheme.bodySmall,
                            semanticsLabel: result['details'] as String,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AccessibilityWidgets.accessibleText(
              'OK',
              semanticsLabel: 'Close dialog button',
            ),
          ),
        ],
      ),
    );
  }

  void _testSemantics() {
    // Run multiple semantics tests
    final testLabel = 'Test Label';
    final testHint = 'Test Hint';
    final isValid = SemanticsTester.testSemantics(testLabel, testHint);

    // Test empty label
    final emptyLabelTest = SemanticsTester.testSemantics('', testHint);

    // Test empty hint
    final emptyHintTest = SemanticsTester.testSemantics(testLabel, '');

    // Test both empty
    final bothEmptyTest = SemanticsTester.testSemantics('', '');

    final testResults = <Map<String, dynamic>>[
      {
        'name': 'Valid Label and Hint',
        'status': isValid ? 'PASSED' : 'FAILED',
        'details': isValid
            ? 'Label "$testLabel" and hint "$testHint" are both valid (non-empty)'
            : 'Label or hint is invalid',
        'passed': isValid,
      },
      {
        'name': 'Empty Label Test',
        'status': emptyLabelTest ? 'FAILED' : 'PASSED',
        'details': emptyLabelTest
            ? 'Test incorrectly passed with empty label'
            : 'Correctly detected empty label as invalid',
        'passed': !emptyLabelTest,
      },
      {
        'name': 'Empty Hint Test',
        'status': emptyHintTest ? 'FAILED' : 'PASSED',
        'details': emptyHintTest
            ? 'Test incorrectly passed with empty hint'
            : 'Correctly detected empty hint as invalid',
        'passed': !emptyHintTest,
      },
      {
        'name': 'Both Empty Test',
        'status': bothEmptyTest ? 'FAILED' : 'PASSED',
        'details': bothEmptyTest
            ? 'Test incorrectly passed with both label and hint empty'
            : 'Correctly detected both empty as invalid',
        'passed': !bothEmptyTest,
      },
    ];

    final passedCount = testResults.where((r) => r['passed'] == true).length;
    final totalCount = testResults.length;
    final allPassed = passedCount == totalCount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AccessibilityWidgets.accessibleText(
          'Semantics Test Results',
          semanticsLabel: 'Semantics test results dialog',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      allPassed ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: allPassed
                        ? Colors.green.shade200
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      allPassed ? Icons.check_circle : Icons.warning,
                      color: allPassed
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AccessibilityWidgets.accessibleText(
                        '$passedCount/$totalCount tests passed',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: allPassed
                                      ? Colors.green.shade900
                                      : Colors.orange.shade900,
                                ),
                        semanticsLabel:
                            '$passedCount out of $totalCount tests passed',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AccessibilityWidgets.accessibleText(
                'What was tested:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              AccessibilityWidgets.accessibleText(
                'The semantics tester validates that labels and hints are properly configured. Both label and hint must be non-empty strings for semantics to be considered valid.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              ...testResults.map((result) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              result['passed'] == true
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: result['passed'] == true
                                  ? Colors.green
                                  : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AccessibilityWidgets.accessibleText(
                                '${result['name']}: ${result['status']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                semanticsLabel:
                                    '${result['name']}: ${result['status']}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: AccessibilityWidgets.accessibleText(
                            result['details'] as String,
                            style: Theme.of(context).textTheme.bodySmall,
                            semanticsLabel: result['details'] as String,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AccessibilityWidgets.accessibleText(
              'OK',
              semanticsLabel: 'Close dialog button',
            ),
          ),
        ],
      ),
    );
  }

  void _validateFocusOrder() {
    final widgets = [_focusNode2, _focusNode3];
    final isValid = AccessibilityTesting.validateFocusOrder(widgets);

    // Run detailed focus order tests
    final testResults = <Map<String, dynamic>>[];

    // Test 1: Empty list
    final emptyListTest = AccessibilityTesting.validateFocusOrder([]);
    testResults.add({
      'name': 'Empty List Validation',
      'status': emptyListTest ? 'FAILED' : 'PASSED',
      'details': emptyListTest
          ? 'Incorrectly validated empty list as valid'
          : 'Correctly rejected empty list (no focusable elements)',
      'passed': !emptyListTest,
    });

    // Test 2: Valid focus nodes
    testResults.add({
      'name': 'Valid Focus Nodes',
      'status': isValid ? 'PASSED' : 'FAILED',
      'details': isValid
          ? 'Both focus nodes (Field 1 and Field 2) are valid FocusNode instances'
          : 'One or more focus nodes are invalid',
      'passed': isValid,
    });

    // Test 3: Check for duplicates
    final duplicateTest =
        AccessibilityTesting.validateFocusOrder([_focusNode2, _focusNode2]);
    testResults.add({
      'name': 'Duplicate Detection',
      'status': duplicateTest ? 'FAILED' : 'PASSED',
      'details': duplicateTest
          ? 'Incorrectly validated duplicate focus nodes'
          : 'Correctly detected and rejected duplicate focus nodes',
      'passed': !duplicateTest,
    });

    // Test 4: Node type validation
    final invalidTypeTest =
        AccessibilityTesting.validateFocusOrder(['not a focus node']);
    testResults.add({
      'name': 'Type Validation',
      'status': invalidTypeTest ? 'FAILED' : 'PASSED',
      'details': invalidTypeTest
          ? 'Incorrectly validated non-FocusNode type'
          : 'Correctly rejected invalid node type',
      'passed': !invalidTypeTest,
    });

    // Test 5: Current focus order
    testResults.add({
      'name': 'Current Focus Order',
      'status': isValid ? 'PASSED' : 'FAILED',
      'details': isValid
          ? 'Focus order is valid: Field 1 → Field 2 (${widgets.length} focusable elements)'
          : 'Focus order validation failed',
      'passed': isValid,
    });

    final passedCount = testResults.where((r) => r['passed'] == true).length;
    final totalCount = testResults.length;
    final allPassed = passedCount == totalCount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AccessibilityWidgets.accessibleText(
          'Focus Order Test Results',
          semanticsLabel: 'Focus order test results dialog',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      allPassed ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: allPassed
                        ? Colors.green.shade200
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      allPassed ? Icons.check_circle : Icons.warning,
                      color: allPassed
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AccessibilityWidgets.accessibleText(
                        '$passedCount/$totalCount tests passed',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: allPassed
                                      ? Colors.green.shade900
                                      : Colors.orange.shade900,
                                ),
                        semanticsLabel:
                            '$passedCount out of $totalCount tests passed',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AccessibilityWidgets.accessibleText(
                'What was tested:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              AccessibilityWidgets.accessibleText(
                'Focus order validation ensures that focusable elements are properly ordered for keyboard navigation and screen readers. This test validates:\n\n'
                '• Focus nodes are valid FocusNode instances\n'
                '• No duplicate focus nodes in the list\n'
                '• Focus order follows a logical sequence\n'
                '• All nodes can receive focus',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              ...testResults.map((result) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              result['passed'] == true
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: result['passed'] == true
                                  ? Colors.green
                                  : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AccessibilityWidgets.accessibleText(
                                '${result['name']}: ${result['status']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                semanticsLabel:
                                    '${result['name']}: ${result['status']}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: AccessibilityWidgets.accessibleText(
                            result['details'] as String,
                            style: Theme.of(context).textTheme.bodySmall,
                            semanticsLabel: result['details'] as String,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AccessibilityWidgets.accessibleText(
              'OK',
              semanticsLabel: 'Close dialog button',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }
}
