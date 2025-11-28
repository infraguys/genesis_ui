import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/repositories/db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_database_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_users_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/databases_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/db_versions_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/pg_users_api.dart';

final class DbaasFactory {
  /// Repositories
  PgDatabasesRepository createDatabasesRepository(BuildContext context) {
    final databasesApi = PgDatabasesApi(context.read<RestClient>());
    return PgDatabasesRepository(databasesApi);
  }

  PgUsersRepository createPgUsersRepository(BuildContext context) {
    final pgUsersApi = PgUsersApi(context.read<RestClient>());
    return PgUsersRepository(pgUsersApi);
  }

  DbVersionsRepository createDbVersionsRepository(BuildContext context) {
    final dbVersionsApi = DbVersionsApi(context.read<RestClient>());
    return DbVersionsRepository(dbVersionsApi);
  }
}
