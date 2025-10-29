import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

class ClusterSelectionCubit extends Cubit<List<Cluster>> {
  ClusterSelectionCubit() : super(List.empty());

  void onToggle(Cluster cluster) {
    final updatedNodes = List.of(state);
    if (updatedNodes.contains(cluster)) {
      updatedNodes.remove(cluster);
    } else {
      updatedNodes.add(cluster);
    }
    emit(updatedNodes);
  }

  void onToggleAll(List<Cluster> cluster) {
    if (state.length == cluster.length) {
      emit(List.empty());
    } else {
      emit(cluster);
    }
  }

  void onClear() => emit(List.empty());
}
