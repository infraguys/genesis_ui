import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

part 'users_selection_event.dart';

class UsersSelectionBloc extends Bloc<UsersSelectionEvent, List<User>> {
  UsersSelectionBloc() : super(List.empty()) {
    on(_onToggle);
    on(_onToggleAll);
    on(_onClear);
  }

  void _onToggle(_Toggle event, Emitter<List<User>> emit) {
    final updatedUsers = List.of(state);
    if (updatedUsers.contains(event.user)) {
      updatedUsers.remove(event.user);
    } else {
      updatedUsers.add(event.user);
    }
    emit(updatedUsers);
  }

  void _onToggleAll(_ToggleAll event, Emitter<List<User>> emit) {
    if (state.length == event.users.length) {
      emit(List.empty());
    } else {
      emit(event.users);
    }
  }

  void _onClear(_Clear event, Emitter<List<User>> emit) {
    emit(List.empty());
  }
}
