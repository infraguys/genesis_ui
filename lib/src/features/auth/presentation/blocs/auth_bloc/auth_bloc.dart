import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/auth/domain/auth_entities/iam_client.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:genesis/src/features/auth/domain/usecases/sign_in_use_case.dart';

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
    final params = CreateTokenParams(username: event.username, password: event.password);

    try {
      final iamClient = await useCase(params);
      if (iamClient != null) {
        emit(Authenticated(iamClient));
      }
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> _signOut(_, Emitter<AuthState> emit) async {
    emit(Unauthenticated());
  }
}
