final class DeleteDatabaseParams {
  DeleteDatabaseParams({
    required this.instanceId,
    required this.databaseId,
    required this.name,
    required this.owner,
    this.description,
  });

  final String instanceId;
  final String databaseId;
  final String name;
  final String owner;
  final String? description;
}
