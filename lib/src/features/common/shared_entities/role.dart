import 'package:equatable/equatable.dart';

class Role extends Equatable {
  const Role({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  final String uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RoleStatus status;
  final dynamic projectId;

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    projectId,
  ];
}

enum RoleStatus { active }
