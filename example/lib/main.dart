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
  final FocusNode _focusNode = FocusNode();

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
      body: Padding(
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
            _buildInteractiveSection(),
            const SizedBox(height: 16),
            _buildTestingSection(),
          ],
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

  Widget _buildInteractiveSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibilityWidgets.accessibleText(
              'Interactive Features',
              style: Theme.of(context).textTheme.titleMedium,
              semanticsLabel: 'Interactive features section',
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Text input field for entering text',
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  hintText: 'Type something here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AccessibilityWidgets.accessibleButton(
                  label: 'Announce Text',
                  onPressed: _announceText,
                  hint:
                      'Double tap to announce the entered text to screen reader',
                ),
                const SizedBox(width: 16),
                AccessibilityWidgets.accessibleButton(
                  label: 'Set Focus',
                  onPressed: _setFocus,
                  hint: 'Double tap to set focus to the text field',
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

  void _setFocus() {
    AccessibilityFocusManager.requestFocus(context, _focusNode);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Focus set to text field'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _runAccessibilityTests() {
    final issues = AccessibilityHelper.validateAccessibility(context);

    if (issues.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All accessibility tests passed!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Accessibility issues found: ${issues.length}'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _testSemantics() {
    final isValid = SemanticsTester.testSemantics('Test Label', 'Test Hint');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Semantics test: ${isValid ? 'PASSED' : 'FAILED'}'),
        backgroundColor: isValid ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
