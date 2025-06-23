import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:genesis/src/features/auth/domain/repositories/i_user_repository.dart';

part './user_event.dart';
part './user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on<_SignUp>(_signUp);
  }

  final IUserRepository _repository;

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
    } on Exception catch (e) {
      // TODO
    }
  }
}
