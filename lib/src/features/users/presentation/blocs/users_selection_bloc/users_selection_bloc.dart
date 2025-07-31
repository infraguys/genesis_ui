import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';

part 'users_selection_event.dart';

class UsersSelectionBloc extends Bloc<UsersSelectionEvent, List<User>> {
  UsersSelectionBloc() : super([]) {
    on<_ToggleUser>(_onToggleUser);
    on<_SelectAllUsers>(_onSelectAllUsers);
  }

  void _onToggleUser(_ToggleUser event, Emitter<List<User>> emit) {
    final updatedUsers = List.of(state);
    if (updatedUsers.contains(event.user)) {
      updatedUsers.remove(event.user);
    } else {
      updatedUsers.add(event.user);
    }
    emit(updatedUsers);
  }

  void _onSelectAllUsers(_SelectAllUsers event, Emitter<List<User>> emit) {
    if (state.length == event.users.length) {
      emit([]);
      return;
    } else {
      emit(event.users);
    }
    emit(event.users);
  }
}
