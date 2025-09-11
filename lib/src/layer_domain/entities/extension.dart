final class Extension {
  Extension({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.version,
    required this.installType,
    required this.link,
  });

  final ExtensionUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String version;
  final String installType;
  final String link;
}

extension type ExtensionUUID(String value) {
  bool isEqualTo(ExtensionUUID other) => value == other.value;
}
