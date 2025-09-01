import 'package:equatable/equatable.dart';

class RoleBinding extends Equatable {
  const RoleBinding({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectUUID,
    required this.userUUID,
    required this.roleUUID,
  });

  final RoleBindingUUID uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String? projectUUID;
  final String userUUID;
  final String roleUUID;

  @override
  List<Object?> get props => [
    uuid,
    createdAt,
    updatedAt,
    status,
    projectUUID,
    userUUID,
    roleUUID,
  ];
}

extension type RoleBindingUUID(String value) {}
