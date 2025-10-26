/*
"uuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "name": "kt2dZSLO0IEm6",
  "description": "",
  "created_at": "2025-10-07T08:36:29.345691Z",
  "updated_at": "2025-10-07T08:36:29.345794Z",
  "project_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "instance": "string",
  "status": "ACTIVE",
  "owner": "string"
*/

import 'package:genesis/src/features/projects/domain/entities/project.dart';

class Database {
  const Database({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.instance,
    required this.status,
    required this.owner,
  });

  final DatabaseID id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectID projectId;
  final String instance;
  final String status;
  final String owner;
}

extension type DatabaseID(String raw) {}

enum DatabaseStatus { newStatus, active, error, inProgress, unknown }
