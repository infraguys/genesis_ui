import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/auth/domain/i_auth_repository.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';

part './user_event.dart';
part './user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on<_SignUp>(_signUp);
  }

  final IAuthRepository _repository;

  Future<void> _signUp(_SignUp event, Emitter<UserState> emit) async {
    emit(UserState.loading());
    try {
      final createdUser = await _repository.singUp(
        SignUpParams(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        ),
      );
      emit(UserState.signUpSuccess());
    } on NetworkException catch (e) {
      emit(UserStateSignUpFailure(e.message));
    }
  }
}
