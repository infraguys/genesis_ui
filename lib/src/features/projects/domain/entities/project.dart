import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectStatus status;

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

enum ProjectStatus {
  newProject,
}
