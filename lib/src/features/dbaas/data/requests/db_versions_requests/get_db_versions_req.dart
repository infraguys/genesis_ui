import 'package:genesis/src/core/network/endpoints/db_versions_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';

extension GetDbVersionsReq on GetDbVersionsParams {
  Map<String, dynamic> toQuery() {
    return {};
  }

  String toPath() {
    return DbVersionsEndpoints.items().fullPath;
  }
}