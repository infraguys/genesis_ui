import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/get_clusters_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/delete_clusters_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/get_clusters_usecase.dart';
import 'package:genesis/src/shared/presentation/polling_bloc_mixin.dart';

part 'clusters_event.dart';

part 'clusters_state.dart';

class ClustersBloc extends Bloc<ClustersEvent, ClustersState> with PollingBlocMixin {
  ClustersBloc(this._repository) : super(_InitialState()) {
    on(_onGetClusters);
    on(_onDeleteClusters);
    on(_onStartPolling);
    on(_onTick, transformer: droppable<_Tick>());
    on(_onStopPolling);
  }

  final IClustersRepository _repository;

  Future<void> _onGetClusters(_GetClusters event, Emitter<ClustersState> emit) async {
    final useCase = GetClustersUseCase(_repository);
    emit(ClustersLoadingState());
    final cluster = await useCase(event.params);
    emit(ClustersLoadedState(cluster));
  }

  Future<void> _onDeleteClusters(_DeleteClusters event, Emitter<ClustersState> emit) async {
    final useCase = DeleteClustersUseCase(_repository);
    emit(ClustersLoadingState());
    await useCase(event.clusters.map((it) => ClusterParams(it.id)).toList());
    emit(ClustersDeletedState(event.clusters));
    add(ClustersEvent.getClusters());
  }

  Future<void> _onStartPolling(_StartPolling e, Emitter<ClustersState> emit) async {
    final params = GetClustersParams();
    polling.start(
      () => add(_Tick(params)),
    );
  }

  Future<void> _onTick(_Tick event, Emitter<ClustersState> emit) async {
    final useCase = GetClustersUseCase(_repository);
    final instances = await useCase(event.params);
    emit(ClustersLoadedState(instances));
  }

  void _onStopPolling(_StopPolling _, Emitter<ClustersState> _) {
    polling.stop();
  }
}
