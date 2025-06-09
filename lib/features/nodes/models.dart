class Node {
  String uuid;
  String created_at;
  String updated_at;
  String project_id;
  String name;
  String description;
  int cores;
  int ram;
  int root_disk_size;
  String image;
  String status;
  String node_type;
  Map<String, dynamic> default_network;

  Node(
    this.uuid,
    this.created_at,
    this.updated_at,
    this.project_id,
    this.name,
    this.description,
    this.cores,
    this.ram,
    this.root_disk_size,
    this.image,
    this.status,
    this.node_type,
    this.default_network,
  );

  factory Node.fromJson(dynamic json) {
    return Node(
      json['uuid'] as String,
      json['created_at'] as String,
      json['updated_at'] as String,
      json['project_id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['cores'] as int,
      json['ram'] as int,
      json['root_disk_size'] as int,
      json['image'] as String,
      json['status'] as String,
      json['node_type'] as String,
      json['default_network'] as Map<String, dynamic>,
    );
  }
}
