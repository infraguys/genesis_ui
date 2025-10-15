import 'package:equatable/equatable.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

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
  final ProjectID? projectUUID;
  final UserUUID userUUID;
  final RoleUUID roleUUID;

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
