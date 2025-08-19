.PHONY: help clean get test analyze format lint build example publish dry-run pana

# Default target
help:
	@echo "Flutter Accessibility Helper - Development Commands"
	@echo ""
	@echo "Available commands:"
	@echo "  get       - Install dependencies"
	@echo "  test      - Run tests"
	@echo "  analyze   - Run Flutter analyze"
	@echo "  format    - Format code with dart format"
	@echo "  lint      - Run linting checks"
	@echo "  build     - Build the package"
	@echo "  example   - Build and run example app"
	@echo "  pana      - Run Pana analysis"
	@echo "  dry-run   - Dry run package publish"
	@echo "  publish   - Publish package to pub.dev"
	@echo "  clean     - Clean build artifacts"
	@echo "  help      - Show this help message"

# Install dependencies
get:
	flutter pub get
	cd example && flutter pub get

# Run tests
test:
	flutter test

# Run Flutter analyze
analyze:
	flutter analyze

# Format code
format:
	dart format .

# Run linting
lint:
	flutter analyze --no-fatal-infos

# Build package
build:
	flutter build

# Build example app
example:
	cd example && flutter build apk --debug

# Run Pana analysis
pana:
	dart pub global activate pana
	pana . --no-warning

# Dry run package publish
dry-run:
	flutter pub publish --dry-run

# Publish package
publish:
	flutter pub publish --force

# Clean build artifacts
clean:
	flutter clean
	cd example && flutter clean
	rm -rf build/
	rm -rf example/build/
	rm -rf .dart_tool/
	rm -rf example/.dart_tool/

# Full analysis pipeline (for CI/CD)
analyze-all: get test analyze format lint pana

# Development setup
setup: get analyze-all

# Pre-publish checks
pre-publish: clean get test analyze format lint pana dry-run
