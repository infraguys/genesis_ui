extension StringExtension on String {
  String get capitalize {
    final firstLetter = this[0].toUpperCase();
    final subString = substring(1).toLowerCase();
    return firstLetter + subString;
  }

  /// A simple placeholder that can be used to search all the hardcoded strings
  /// in the code (useful to identify strings that need to be localized).
  String get hardcoded => this;
}