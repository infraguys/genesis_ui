import 'package:equatable/equatable.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';

class Role extends Equatable {
  const Role({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  final RoleUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Status status;
  final dynamic projectId;

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    createdAt,
    updatedAt,
    status,
    projectId,
  ];
}

// // Copyable extension ----------
//
// extension RoleCopyable on Role {
//   Role copyWith({
//     String? uuid,
//     String? name,
//     String? description,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     Status? status,
//     dynamic projectId,
//   }) {
//     return Role(
//       uuid: uuid ?? this.uuid,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       status: status ?? this.status,
//       projectId: projectId ?? this.projectId,
//     );
//   }
// }

extension type RoleUUID(String value) {}
