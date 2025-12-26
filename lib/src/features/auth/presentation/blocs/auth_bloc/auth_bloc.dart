import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/force_refresh_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/get_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/restore_session_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/sign_out_usecase.dart';
import 'package:genesis/src/features/permissions/permission_names/permission_names.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/usecases/create_user_usecase.dart';
import 'package:logging/logging.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetTokenUseCase getTokenUseCase,
    required SignOutUseCase signOutUseCase,
    required RestoreSessionUseCase restoreSessionUseCase,
    required ForceRefreshTokenUseCase forceRefreshTokenUseCase,
    required CreateUserUseCase createUserUseCase,
  }) : _getTokenUseCase = getTokenUseCase,
       _signOutUseCase = signOutUseCase,
       _restoreSessionUseCase = restoreSessionUseCase,
       _forceRefreshTokenUseCase = forceRefreshTokenUseCase,
       _createUserUseCase = createUserUseCase,
       super(_InitialState()) {
    on(_onSignIn);
    on(_onSignUp);
    on(_onSignOut);
    on(_onRestoreSession);
    on(_onRefreshToken);

    add(AuthEvent.restoreSession());
  }

  static final _log = Logger('AuthBlocLogger');

  final GetTokenUseCase _getTokenUseCase;
  final SignOutUseCase _signOutUseCase;
  final RestoreSessionUseCase _restoreSessionUseCase;
  final ForceRefreshTokenUseCase _forceRefreshTokenUseCase;
  final CreateUserUseCase _createUserUseCase;

  Future<void> _onSignIn(_SingIn event, Emitter<AuthState> emit) async {
    try {
      final authSession = await _getTokenUseCase(event.params);
      _log.info('authSession obtained: User=${authSession.user.username}, scope=${authSession.scope}');
      emit(AuthenticatedAuthState(authSession));
      _log.info('Emitted AuthenticatedAuthState');
    } on ApiException catch (e) {
      emit(AuthStateFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthStateFailure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _onSignUp(_SingUp event, Emitter<AuthState> emit) async {
    try {
      await _createUserUseCase(
        CreateUserParams(
          username: event.params.username,
          email: event.params.email,
          password: event.params.password,
        ),
      );

      final authSession = await _getTokenUseCase(
        GetTokenParams(username: event.params.username, password: event.params.password),
      );
      emit(AuthenticatedAuthState(authSession));
    } on ApiException catch (e) {
      emit(AuthStateFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthStateFailure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _onSignOut(_SingOut _, Emitter<AuthState> emit) async {
    await _signOutUseCase();
    emit(UnauthenticatedAuthState());
  }

  Future<void> _onRestoreSession(_RestoreSession event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      final authSession = await _restoreSessionUseCase();
      emit(AuthenticatedAuthState(authSession));
    } on NoTokenException catch (_) {
      emit(UnauthenticatedAuthState());
    } on ApiException catch (e) {
      emit(AuthStateFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthStateFailure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _onRefreshToken(_RefreshToken event, Emitter<AuthState> emit) async {
    try {
      final authSession = await _forceRefreshTokenUseCase(event._params);
      emit(AuthenticatedAuthState(authSession));
    } on ApiException catch (e) {
      emit(AuthStateFailure(e.message));
    } on NetworkException catch (e) {
      emit(AuthStateFailure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
