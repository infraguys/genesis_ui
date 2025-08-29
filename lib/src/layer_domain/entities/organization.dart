import 'package:equatable/equatable.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';

class Organization extends Equatable {
  const Organization({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final OrganizationUUID uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Status status;

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

extension type OrganizationUUID(String value) {}
