import 'package:equatable/equatable.dart';

class RoleBinding extends Equatable {
  const RoleBinding({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.project,
    required this.user,
    required this.role,
  });

  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String? project;
  final String user;
  final String role;

  @override
  List<Object?> get props => [
    uuid,
    createdAt,
    updatedAt,
    status,
    project,
    user,
    role,
  ];
}
