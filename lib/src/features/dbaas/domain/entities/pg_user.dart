import 'package:genesis/src/features/projects/domain/entities/project.dart';

class PgUser {
  PgUser({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.instance,
    required this.status,
    required this.password,
  });

  final PgUserID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectID projectId;
  final String instance;
  final PgUserStatus status;
  final String password;
}

extension type PgUserID(String raw) {}

enum PgUserStatus { newStatus, active, error, inProgress, unknown }
