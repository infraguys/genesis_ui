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
	@echo "  dev-web        	- 🌐 Run dev web app"
	@echo "  prod-web       	- 🚀 Run prod web app"
	@echo "  gen       			- 🛠 Generating code with build_runner…"
	@echo "  all                - ⚙️ Run clean, analyze, format"
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
dev-web:
	@echo "🌐 Running development debug web app..."
	flutter run -d chrome --debug

# Run prod web app
prod-web:
	@echo "🚀 Building production web app..."
	flutter build web --release --base-href "/"

# Default target when running just 'make'
all:
	@echo "⚙️ Start cleaning, analyzing, formatting.."
	clean
	analyze
	format
	@echo "✅ All development tasks completed!"