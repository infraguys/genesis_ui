import 'package:genesis/src/features/common/shared_entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum OrganizationStatusReq {
  @JsonValue('ACTIVE')
  active;

  factory OrganizationStatusReq.fromOrganizationStatus(Status status) {
    return switch (status) {
      Status.active => OrganizationStatusReq.active,
      Status.inactive => throw UnimplementedError(),
    };
  }
}
