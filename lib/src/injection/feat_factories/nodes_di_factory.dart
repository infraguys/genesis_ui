import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/nodes/data/repositories/nodes_repository.dart';
import 'package:genesis/src/features/nodes/data/sources/nodes_api.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';

final class NodesDiFactory {
  /// Repositories
  NodesRepository createNodesRepository(BuildContext context) {
    final nodesApi = NodesApi(context.read<RestClient>());
    return NodesRepository(nodesApi);
  }

  /// Blocs

  NodesBloc createNodesBloc(BuildContext context) {
    final repository = context.read<INodesRepository>();
    return NodesBloc(repository);
  }
}
