import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/create_cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/update_cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/create_cluster_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/delete_cluster_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/get_cluster_usecase.dart';
import 'package:genesis/src/features/dbaas/domain/use_cases/clusters_usecases/update_cluster_usecase.dart';
import 'package:genesis/src/shared/presentation/polling_bloc_mixin.dart';

part 'cluster_event.dart';

part 'cluster_state.dart';

class ClusterBloc extends Bloc<ClusterEvent, ClusterState> with PollingBlocMixin {
  ClusterBloc(this._repository) : super(_InitialState()) {
    on(_onCreateCluster);
    on(_onGetCluster);
    on(_onDeleteCluster);
    on(_onUpdateCluster);
    on(_onStartPolling);
    on(_onStopPolling);
    on(_onTick, transformer: droppable<_Tick>());
  }

  final IClustersRepository _repository;

  Future<void> _onGetCluster(_Get event, Emitter<ClusterState> emit) async {
    final useCase = GetClusterUseCase(_repository);
    emit(ClusterLoadingState());
    final cluster = await useCase(ClusterParams(event.id));
    emit(ClusterLoadedState(cluster));
  }

  Future<void> _onCreateCluster(_Create event, Emitter<ClusterState> emit) async {
    final useCase = CreateClusterUseCase(_repository);
    try {
      final cluster = await useCase(event.params);
      emit(ClusterCreatedState(cluster));
    } on PermissionException catch (_) {
      // TODO(Koretsky): implement permission failure state
      // emit(NodePermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(ClusterFailureState(e.message));
    } on NetworkException catch (e) {
      emit(ClusterFailureState(e.message));
    }
  }

  Future<void> _onDeleteCluster(_Delete event, Emitter<ClusterState> emit) async {
    final useCase = DeleteClusterUseCase(_repository);
    try {
      await useCase(ClusterParams(event.cluster.id));
      emit(ClusterDeletedState(event.cluster));
    } on PermissionException catch (e) {
      // emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdateCluster(_Update event, Emitter<ClusterState> emit) async {
    final useCase = UpdateClusterUseCase(_repository);
    try {
      final cluster = await useCase(event.params);
      emit(ClusterUpdatedState(cluster));
    } on PermissionException catch (e) {
      // emit(NodePermissionFailureState(e.message));
    }
  }

  Future<void> _onStartPolling(_StartPolling event, Emitter<ClusterState> emit) async {
    polling.start(
      () => add(_Tick(event.id)),
    );
  }

  Future<void> _onTick(_Tick event, Emitter<ClusterState> emit) async {
    final useCase = GetClusterUseCase(_repository);
    final cluster = await useCase(ClusterParams(event.id));
    emit(ClusterLoadedState(cluster));
  }

  void _onStopPolling(_StopPolling _, Emitter<ClusterState> _) {
    polling.stop();
  }
}
