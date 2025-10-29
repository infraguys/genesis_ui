import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';

class NodesSelectionCubit extends Cubit<List<Node>> {
  NodesSelectionCubit() : super(List.empty());

  void onToggle(Node node) {
    final updatedNodes = List.of(state);
    if (updatedNodes.contains(node)) {
      updatedNodes.remove(node);
    } else {
      updatedNodes.add(node);
    }
    emit(updatedNodes);
  }

  void onToggleAll(List<Node> nodes) {
    if (state.length == nodes.length) {
      emit(List.empty());
    } else {
      emit(nodes);
    }
  }

  void onClear() {
    emit(List.empty());
  }
}
