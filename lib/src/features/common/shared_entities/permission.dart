import 'package:equatable/equatable.dart';

class Permission extends Equatable {
  const Permission({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PermissionStatus status;

  @override
  List<Object?> get props => [uuid, name, description, createdAt, updatedAt, status];

  @override
  String toString() {
    return '''
Permission(
  uuid: $uuid,
  name: $name,
  description: $description,
  createdAt: $createdAt,
  updatedAt: $updatedAt,
  status: $status
)''';
  }
}

enum PermissionStatus { active }
