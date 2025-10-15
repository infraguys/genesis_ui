import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  const Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final OrganizationID id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrganizationStatus status;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    status,
  ];
}

enum OrganizationStatus { active, unknown }

extension type OrganizationID(String value) {
  bool isEqualTo(OrganizationID other) => value == other.value;
}
