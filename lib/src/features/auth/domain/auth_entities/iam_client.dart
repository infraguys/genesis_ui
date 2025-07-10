import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';

class IamClient {
  IamClient({required this.user, required this.organizations});

  final User user;
  final List<Organization> organizations;
}
