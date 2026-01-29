import 'package:equatable/equatable.dart';

class Permission extends Equatable {
  const Permission({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final PermissionID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PermissionStatus status;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    status,
  ];
}

extension type PermissionID(String raw) {
  bool isEqualTo(PermissionID other) => raw == other.raw;
}

enum PermissionStatus { active, unknown }
