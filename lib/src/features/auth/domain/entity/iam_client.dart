import 'package:genesis/src/features/shared/user.dart';

import 'organization.dart';

class IamClient {
  IamClient({required this.user, required this.organizations});

  final User user;
  final List<Organization> organizations;
}
