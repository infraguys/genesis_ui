import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/params/get_organizations_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_organizations_req.g.dart';

@JsonSerializable(createFactory: false)
final class GetOrganizationsReq {
  GetOrganizationsReq(GetOrganizationsParams params)
    : name = params.name,
      description = params.description,
      createdAt = params.createdAt,
      updatedAt = params.updatedAt,
      status = _fromStatus(params.status);

  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? description;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(includeIfNull: false)
  final String? status;

  Map<String, dynamic> toQuery() => _$GetOrganizationsReqToJson(this);

  static String? _fromStatus(Status? status) {
    return switch (status) {
      Status.active => 'ACTIVE',
      _ => null,
    };
  }
}
