import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_projects_req.g.dart';

@JsonSerializable(createFactory: false, constructor: '_')
final class GetProjectsReq implements IReq {
  factory GetProjectsReq(GetProjectsParams params) {
    return GetProjectsReq._(
      userUuid: params.userUuid,
    );
  }

  GetProjectsReq._({
    required this.userUuid,
  });

  @override
  Map<String, dynamic> toJson() => _$GetProjectsReqToJson(this);

  final String userUuid;
}
