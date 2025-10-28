import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class CreatePgUserParams {
  CreatePgUserParams({
    required this.pgInstanceId,
    required this.name,
    required this.password,
    this.description,
  });

  final ClusterID pgInstanceId;
  final String name;
  final String password;
  final String? description;
}
