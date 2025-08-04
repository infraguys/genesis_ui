import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roles_bindings.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class RolesBindingsDto implements IDto<dynamic> {
  RolesBindingsDto._({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.user,
    required this.role,
    required this.project,
  });

  factory RolesBindingsDto.fromJson(Map<String, dynamic> json) => _$RolesBindingsDtoFromJson(json);

  final String uuid;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final String status;
  final String? project;
  final String user;
  final String role;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

  @override
  toEntity() {
    throw UnimplementedError();
  }
}
