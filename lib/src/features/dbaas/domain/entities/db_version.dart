class DbVersion {
  DbVersion({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  final DbVersionID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image;
}

extension type DbVersionID(String raw) {}