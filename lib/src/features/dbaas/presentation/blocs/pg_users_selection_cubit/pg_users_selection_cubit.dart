import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

class PgUsersSelectionCubit extends Cubit<List<PgUser>> {
  PgUsersSelectionCubit() : super(List.empty());

  void onToggle(PgUser database) {
    final copiedUsers = List.of(state);
    if (copiedUsers.contains(database)) {
      copiedUsers.remove(database);
    } else {
      copiedUsers.add(database);
    }
    emit(copiedUsers);
  }

  void onToggleAll(List<PgUser> pgUsers) {
    if (state.length == pgUsers.length) {
      emit(List.empty());
    } else {
      emit(pgUsers);
    }
  }

  void onClear() {
    emit(List.empty());
  }
}
