import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

class PgInstanceSelectionCubit extends Cubit<List<PgInstance>> {
  PgInstanceSelectionCubit() : super(List.empty());

  void onToggle(PgInstance instance) {
    final updatedNodes = List.of(state);
    if (updatedNodes.contains(instance)) {
      updatedNodes.remove(instance);
    } else {
      updatedNodes.add(instance);
    }
    emit(updatedNodes);
  }

  void onToggleAll(List<PgInstance> instance) {
    if (state.length == instance.length) {
      emit(List.empty());
    } else {
      emit(instance);
    }
  }

  void onClear() {
    emit(List.empty());
  }
}
