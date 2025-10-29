import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/confirm_email_params.dart';

extension ConfirmEmailParamsX on ConfirmEmailParams {
  Map<String, dynamic> toJson() {
    return {};
  }

  String toPath() {
    return UsersEndpoints.confirmUserEmail(id).fullPath;
  }
}
