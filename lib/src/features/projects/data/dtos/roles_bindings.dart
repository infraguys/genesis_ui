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

  static DateTime _fromIsoStringToDateTime(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

  @override
  toEntity() {
    throw UnimplementedError();
  }
}

//"uuid": "e82011d4-5ab2-41bf-9df0-13c8c3bfe987",
//     "created_at": "2025-07-08T23:02:24.965314Z",
//     "updated_at": "2025-07-08T23:02:24.965316Z",
//     "status": "ACTIVE",
//     "user": "/v1/iam/users/c35e94de-fe43-4a3a-9ea1-c50f4289b7ab",
//     "role": "/v1/iam/roles/726f6c65-0000-0000-0000-000000000001"
