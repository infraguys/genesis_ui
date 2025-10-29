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
    required this.projectLink,
    required this.userLink,
    required this.roleLink,
  });

  UserID get userId => UserID(userLink.split('/').last);

  RoleUUID get roleId => RoleUUID(roleLink.split('/').last);

  ProjectID? get projectId {
    if (projectLink == null) {
      return null;
    }
    return ProjectID(projectLink!.split('/').last);
  }

  final RoleBindingUUID uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String? projectLink;
  final String userLink;
  final String roleLink;

  @override
  List<Object?> get props => [
    uuid,
    createdAt,
    updatedAt,
    status,
    projectLink,
    userLink,
    roleLink,
  ];
}

extension type RoleBindingUUID(String value) {}
