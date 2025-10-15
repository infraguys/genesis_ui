import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/force_refresh_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/get_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/restore_session_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/sign_out_usecase.dart';
import 'package:genesis/src/features/permissions/permission_names/permission_names.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(UnauthenticatedAuthState()) {
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
    final useCase = SignOutUseCase(_authRepository);
    await useCase();
    emit(UnauthenticatedAuthState());
  }

  Future<void> _onRestoreSession(_RestoreSession event, Emitter<AuthState> emit) async {
    final useCase = RestoreSessionUseCase(_authRepository);
    emit(AuthStateLoading());
    try {
      final authSession = await useCase();
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
    final useCase = ForceRefreshTokenUseCase(_authRepository);

    try {
      final authSession = await useCase(event._params);
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
