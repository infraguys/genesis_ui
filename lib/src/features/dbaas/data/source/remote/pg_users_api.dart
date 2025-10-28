import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/dtos/pg_user_dto.dart';
import 'package:genesis/src/features/dbaas/data/requests/pg_users_requests/create_pg_user_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/pg_users_requests/get_pg_users_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/pg_users_requests/pg_user_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/pg_users_requests/update_pg_user_req.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_user_params.dart';

final class PgUsersApi {
  PgUsersApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  Future<PgUserDto> getPgUser(PgUserParams req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return PgUserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deletePgUser(PgUserParams req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgUserDto> createPgUser(CreatePgUserParams req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return PgUserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgUserDto> updatePgUser(UpdatePgUserParams req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return PgUserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  /// Multiple instances methods
  ///
  /// Методы для работы с несколькими экземплярами

  Future<List<PgUserDto>> getPgUsers(GetPgUsersParams req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => PgUserDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
