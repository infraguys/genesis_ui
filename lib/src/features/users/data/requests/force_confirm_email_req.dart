import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/force_confirm_email_params.dart';

extension ForceConfirmEmailParamsX on ForceConfirmEmailParams {
  String toPath() => UsersEndpoints.forceConfirmUserEmail(id);
}
