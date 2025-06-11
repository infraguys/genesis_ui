import 'package:flutter/material.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {

  /// Shortcut for [AppLocalizations.of(context)]
  AppLocalizations get $ => AppLocalizations.of(this);
}