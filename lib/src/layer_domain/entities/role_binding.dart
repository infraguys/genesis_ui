import 'package:equatable/equatable.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

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
  final ProjectUUID? projectUUID;
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
