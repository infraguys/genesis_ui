# Declare all targets as phony (not representing files)
.PHONY: help clean format gen loc dev-web prod-web ci

#------------------------------------------------------
# Development Commands
#------------------------------------------------------

# Display help information
help:
	@echo "Available targets:"
	@printf "  %-20s - 🧹  %s\n" "clean" "Clean build artifacts and get dependencies"
	@printf "  %-20s - 🖌️  %s\n" "format" "Format Dart code"
	@printf "  %-20s - 🛠  %s\n" "gen" "Generating code with build_runner…"
	@printf "  %-20s - 🌎  %s\n" "loc" "Project localization"
	@printf "  %-20s - 🌐  %s\n" "dev-web" "Run dev web app"
	@printf "  %-20s - 🚀  %s\n" "prod-web" "Run prod web app"
	@printf "  %-20s - 🤖  %s\n" "ci" "Run CI/CD pipeline (cleaning, localization, generation)"
	@printf "  %-20s - ℹ️  %s\n" "help" "Display this help message"

# Clean build artifacts and get dependencies
clean:
	@echo "🧹 Cleaning Flutter project..."
	flutter clean
	yes | flutter pub cache clean
	@echo "Getting dependencies..."
	flutter pub get

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

# Localization project
loc:
	@echo "🛠 Localization project with l10n…"
	flutter gen-l10n \
		--arb-dir lib/src/l10n \
		--output-dir lib/src/l10n/generated \
		--output-localization-file app_localizations.dart \
		--untranslated-messages-file lib/src/l10n/untranslated.txt \
		--no-nullable-getter \
		--format
	@echo "✅ localization completed successfully!"

# Run dev web app
dev-web:
	@echo "🌐 Running development debug web app..."
	flutter run -d chrome --debug

# Run prod web app
prod-web:
	@echo "🚀 Building production web app..."
	flutter build web --release --dart-define-from-file=env.json --base-href "/"

ci:
	echo "🤖Running CI/CD pipeline (cleaning, localization, generation)"
	$(MAKE) format
	$(MAKE) clean
	$(MAKE) loc
	$(MAKE) gen
	$(MAKE) prod-web
	@echo "✅ All development tasks completed!"