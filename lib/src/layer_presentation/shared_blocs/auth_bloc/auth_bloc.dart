import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/sign_in_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._iamClientRepository) : super(AuthState.unauthenticated()) {
    on<_SingIn>(_signIn);
    on<_SingOut>(_signOut);
  }

  final IAuthRepository _iamClientRepository;

  Future<void> _signIn(_SingIn event, Emitter<AuthState> emit) async {
    final useCase = SignInUseCase(_iamClientRepository);
    final params = SignInParams(username: event.username, password: event.password);

    try {
      final user = await useCase(params);
      emit(AuthState.authenticated(user));
    } on DataNotFoundException catch (e) {
      emit(AuthState.failure(e.message));
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _signOut(_, Emitter<AuthState> emit) async {
    emit(AuthState.unauthenticated());
  }
}
