final class CreateClusterParams {
  CreateClusterParams({
    required this.name,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.versionLink,
    this.description,
  });

  final String name;
  final String? description;
  final int cores;
  final int ram;
  final int diskSize;
  final int nodesNumber;
  final int syncReplicaNumber;
  final String versionLink;
}
