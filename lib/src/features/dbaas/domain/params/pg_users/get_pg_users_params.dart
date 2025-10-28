import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class GetPgUsersParams {
  GetPgUsersParams({required this.pgInstanceId});

  final ClusterID pgInstanceId;
}
