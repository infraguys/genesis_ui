import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';

class DatabasesSelectionCubit extends Cubit<List<Database>> {
  DatabasesSelectionCubit() : super(List.empty());

  void onToggle(Database database) {
    final updatedNodes = List.of(state);
    if (updatedNodes.contains(database)) {
      updatedNodes.remove(database);
    } else {
      updatedNodes.add(database);
    }
    emit(updatedNodes);
  }

  void onToggleAll(List<Database> databases) {
    if (state.length == databases.length) {
      emit(List.empty());
    } else {
      emit(databases);
    }
  }

  void onClear() {
    emit(List.empty());
  }
}
