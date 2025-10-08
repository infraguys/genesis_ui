import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/layer_domain/entities/auth_session.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';
import 'package:genesis/src/layer_domain/params/get_token_params.dart';
import 'package:genesis/src/layer_domain/params/users/refresh_token_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/auth_usecases/force_refresh_token_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/auth_usecases/get_token_use_case.dart';
import 'package:genesis/src/layer_domain/use_cases/auth_usecases/restore_session_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/auth_usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(AuthState.unauthenticated()) {
    on(_onSignIn);
    on(_onSignOut);
    on(_onRestoreSession);
    on(_onRefreshToken);
  }

  final IAuthRepository _authRepository;

  Future<void> _onSignIn(_SingIn event, Emitter<AuthState> emit) async {
    final useCase = GetTokenUseCase(_authRepository);

    try {
      final authSession = await useCase(GetTokenParams(username: event.username, password: event.password));
      emit(AuthState.authenticated(authSession));
    } on ApiException catch (e) {
      emit(AuthState.failure(e.message));
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _onSignOut(_SingOut _, Emitter<AuthState> emit) async {
    final useCase = SignOutUseCase(_authRepository);
    await useCase();
    emit(AuthState.unauthenticated());
  }

  Future<void> _onRestoreSession(_RestoreSession event, Emitter<AuthState> emit) async {
    final useCase = RestoreSessionUseCase(_authRepository);
    emit(AuthState.loading());
    try {
      final authSession = await useCase();
      emit(AuthState.authenticated(authSession));
    } on NoTokenException catch (_) {
      emit(AuthState.unauthenticated());
    } on ApiException catch (e) {
      emit(AuthState.failure(e.message));
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _onRefreshToken(_RefreshToken event, Emitter<AuthState> emit) async {
    final useCase = ForceRefreshTokenUseCase(_authRepository);

    try {
      final authSession = await useCase(event._params);
      emit(AuthState.authenticated(authSession));
    } on ApiException catch (e) {
      emit(AuthState.failure(e.message));
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
