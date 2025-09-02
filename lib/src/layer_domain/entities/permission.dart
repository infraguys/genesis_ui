import 'package:equatable/equatable.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';

class Permission extends Equatable {
  const Permission({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final PermissionUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Status status;

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    createdAt,
    updatedAt,
    status,
  ];
}

extension type PermissionUUID(String value) {
  bool isEqualTo(PermissionUUID other) => value == other.value;
}
