import 'package:equatable/equatable.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

class Database extends Equatable{
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectID projectId;
  final String instance;
  final DatabaseStatus status;
  final String owner;
  final String? description;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdAt,
        updatedAt,
        projectId,
        instance,
        status,
        owner,
      ];
}

extension type DatabaseID(String raw) {}

enum DatabaseStatus { newStatus, active, error, inProgress, unknown }
