import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/users/data/dtos/user_dto.dart';
import 'package:genesis/src/features/users/data/requests/change_user_password_req.dart';
import 'package:genesis/src/features/users/data/requests/confirm_email_req.dart';
import 'package:genesis/src/features/users/data/requests/create_user_req.dart';
import 'package:genesis/src/features/users/data/requests/delete_user_req.dart';
import 'package:genesis/src/features/users/data/requests/force_confirm_email_req.dart';
import 'package:genesis/src/features/users/data/requests/get_user_req.dart';
import 'package:genesis/src/features/users/data/requests/get_users_req.dart';
import 'package:genesis/src/features/users/data/requests/update_user_req.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/users/domain/params/confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/params/force_confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';

final class UsersApi {
  UsersApi(this._client);

  final RestClient _client;

  Future<List<UserDto>> getUsers(GetUsersParams params) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        params.toPath(),
        queryParameters: params.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => UserDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> changeUserPassword(ChangeUserPasswordParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
        data: params.toJson(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {}
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> confirmEmail(ConfirmEmailParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> forceConfirmEmail(ForceConfirmEmailParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> createUser(CreateUserParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
        data: params.toJson(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteUser(DeleteUserParams params) async {
    try {
      await _client.delete<void>(
        params.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> getUser(GetUserParams params) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        params.toPath(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<UserDto> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  Future<UserDto> updateUser(UpdateUserParams req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
