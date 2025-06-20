# Declare all targets as phony (not representing files)
.PHONY: help clean analyze format run-dev-web run-prod-web all cp

#------------------------------------------------------
# Development Commands
#------------------------------------------------------

# Display help information
help:
	@echo "Flutter Development Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  clean              - 🧹 Clean build artifacts and get dependencies"
	@echo "  analyze            - 🔍 Run static code analysis"
	@echo "  format             - 🖌️ Format Dart code"
	@echo "  run-dev-web        - 🌐 Run dev web app"
	@echo "  run-prod-web       - 🚀 Run prod web app"
	@echo "  gen       			- 🛠 Generating code with build_runner…"
	@echo "  all                - ⚙️ Run clean, analyze, format"
	@#echo "  cp                 - Copy apk file to Download folder"
	@echo "  help               - Display this help message"

# Clean build artifacts and get dependencies
clean:
	@echo "🧹 Cleaning Flutter project..."
	flutter clean
	flutter pub cache clean
	@echo "Getting dependencies..."
	flutter pub get

# Run static code analysis
analyze:
	@echo "🔍 Running Flutter analyzer..."
	flutter analyze

# Format Dart code
format:
	@echo "🖌️ Formatting Dart code..."
	dart format lib

#------------------------------------------------------
# Build Commands
#------------------------------------------------------

# Generating code
gen:
	@echo "🛠 Generating code with build_runner…"
	flutter pub run build_runner build --delete-conflicting-outputs

# Run dev web app
run-dev-web:
	@echo "🌐 Building development debug web app..."
	flutter run web --debug --web-port=9999 --dart-define=flavor=.development

# Run prod web app
run-prod-web:
	@echo "🚀 Building production web app..."
	flutter run web --release --base-href "/"

# Default target when running just 'make'
all:
	@echo "⚙️ Start cleaning, analyzing, formatting.."
	clean
	analyze
	format
	@echo "✅ All development tasks completed!"
#
#cp:
#	@echo "Copy app-development-release.apk to 'Downloads' folder"
#	cp build/app/outputs/flutter-apk/*.apk ~/Downloads/