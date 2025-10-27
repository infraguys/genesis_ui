import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_users_params.dart';

abstract interface class IPgUserRepository {
  Future<PgUser> getPgUser(PgUserParams params);

  Future<List<PgUser>> getPgUsers(GetPgUsersParams params);

  Future<PgUser> createPgUser(CreatePgUserParams params);

  Future<PgUser> updatePgUser(UpdatePgUsersParams params);

  Future<void> deletePgUser(PgUserParams params);
}
