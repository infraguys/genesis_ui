import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/nodes/data/repositories/nodes_repository.dart';
import 'package:genesis/src/features/nodes/data/sources/nodes_api.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/domain/usecases/create_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/delete_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/delete_nodes_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/get_node_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/get_nodes_usecase.dart';
import 'package:genesis/src/features/nodes/domain/usecases/update_node_usecase.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_selection_cubit/nodes_selection_cubit.dart';

final class NodesDiFactory {
  /// Repositories
  ///
  NodesRepository makeNodesRepository(BuildContext context) {
    final nodesApi = NodesApi(context.read<RestClient>());
    return NodesRepository(nodesApi);
  }

  /// Blocs
  ///
  NodesBloc makeNodesBloc(BuildContext context) {
    final repository = context.read<INodesRepository>();
    return NodesBloc(
      getNodesUseCase: GetNodesUseCase(repository),
      deleteNodesUseCase: DeleteNodesUseCase(repository),
    );
  }

  NodeBloc makeNodeBloc(BuildContext context) {
    final repository = context.read<INodesRepository>();
    return NodeBloc(
      getNodeUseCase: GetNodeUseCase(repository),
      createNodeUseCase: CreateNodeUseCase(repository),
      deleteNodeUseCase: DeleteNodeUseCase(repository),
      updateNodeUseCase: UpdateNodeUseCase(repository),
    );
  }

  NodesSelectionCubit makeNodesSelectionCubit() {
    return NodesSelectionCubit();
  }
}
