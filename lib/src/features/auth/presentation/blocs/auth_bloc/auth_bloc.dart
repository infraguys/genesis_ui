import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/repositories/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/use_case/sign_in_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._iamClientRepository) : super(AuthState.init()) {
    on<_SingIn>(_signIn);
    on<_SingOut>(_signOut);
  }

  final IIamClientRepository _iamClientRepository;

  Future<void> _signIn(_SingIn event, Emitter<AuthState> emit) async {
    final useCase = SignInUseCase(_iamClientRepository);
    final params = CreateTokenParams(
      iamClientUuid: '00000000-0000-0000-0000-000000000000',
      grantType: 'password',
      clientId: 'GenesisCoreClientId',
      clientSecret: 'GenesisCoreClientSecret',
      username: event.username,
      password: event.password,
      refreshTtl: 0,
      ttl: 31536000,
    );

    try {
      final iamClient = await useCase(params);
      if (iamClient != null) {
        emit(Authenticated(iamClient));
      }
    } on NetworkException catch (e) {
      emit(AuthState.failure(e.message));
    } on Exception catch (e) {
      print('ce');
    }
  }

  Future<void> _signOut(_, Emitter<AuthState> emit) async {
    emit(Unauthenticated());
  }
}
