import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

part 'users_selection_event.dart';

class UsersSelectionBloc extends Bloc<UsersSelectionEvent, List<User>> {
  UsersSelectionBloc() : super([]) {
    on(_onToggleUser);
    on(_onSelectAllUsers);
    on(_onClearSelection);
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

  void _onClearSelection(_ClearSelection event, Emitter<List<User>> emit) {
    emit([]);
  }
}
