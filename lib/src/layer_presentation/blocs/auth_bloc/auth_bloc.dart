import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/auth_usecases/restore_session_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/sign_in_use_case.dart';
import 'package:genesis/src/layer_domain/use_cases/users/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._iamClientRepository) : super(AuthState.unauthenticated()) {
    on(_signIn);
    on(_signOut);
    on(_restoreSession);
  }

  final IAuthRepository _iamClientRepository;

  Future<void> _signIn(_SingIn event, Emitter<AuthState> emit) async {
    final useCase = SignInUseCase(_iamClientRepository);

    try {
      final user = await useCase(SignInParams(username: event.username, password: event.password));
      emit(AuthState.authenticated(user));
    } on DataNotFoundException catch (e) {
      emit(AuthState.failure(e.message));
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _signOut(_SingOut _, Emitter<AuthState> emit) async {
    final useCase = SignOutUseCase(_iamClientRepository);
    emit(AuthState.unauthenticated());
    await useCase();
  }

  Future<void> _restoreSession(_RestoreSession event, Emitter<AuthState> emit) async {
    final useCase = RestoreSessionUseCase(_iamClientRepository);
    emit(AuthState.loading());
    try {
      final user = await useCase();
      emit(AuthState.authenticated(user));
    } on NoTokenException catch (_) {
      emit(AuthState.unauthenticated());
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
