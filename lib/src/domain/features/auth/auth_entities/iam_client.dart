import 'package:genesis/src/domain/entities/organization.dart';
import 'package:genesis/src/domain/entities/user.dart';

class IamClient {
  IamClient({required this.user, required this.organizations});

  final User user;
  final List<Organization> organizations;
}
