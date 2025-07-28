import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/organizations/data/requests/organization_status_req.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_organizations_req.g.dart';

@JsonSerializable(createFactory: false)
final class GetOrganizationsReq implements IReq {
  GetOrganizationsReq(GetOrganizationsParams params)
    : name = params.name,
      description = params.description,
      createdAt = params.createdAt,
      updatedAt = params.updatedAt,
      status = params.status != null ? OrganizationStatusReq.fromOrganizationStatus(params.status!) : null;

  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? description;
  @JsonKey(includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(includeIfNull: false)
  final OrganizationStatusReq? status;

  @override
  Map<String, dynamic> toJson() => _$GetOrganizationsReqToJson(this);

  @override
  String toString() {
    return '''
GetOrganizationsReq(
  name: $name,
  description: $description,
  createdAt: $createdAt,
  updatedAt: $updatedAt,
  status: $status,
)''';
  }
}
