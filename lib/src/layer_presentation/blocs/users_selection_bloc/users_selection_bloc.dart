import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

class UsersSelectionCubit extends Cubit<List<User>> {
  UsersSelectionCubit() : super(List.empty());

  void onToggle(User user) {
    final copiedUsers = List.of(state);
    if (copiedUsers.contains(user)) {
      copiedUsers.remove(user);
    } else {
      copiedUsers.add(user);
    }
    emit(copiedUsers);
  }

  void onToggleAll(List<User> users) {
    if (state.length == users.length) {
      emit(List.empty());
    } else {
      emit(users);
    }
  }

  void onClear() {
    emit(List.empty());
  }
}
