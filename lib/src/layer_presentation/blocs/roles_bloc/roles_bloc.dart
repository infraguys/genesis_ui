import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/delete_roles_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_roles.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  RolesBloc(this._repository) : super(RolesState.init()) {
    on(_onGetRoles);
    on(_onDeleteRoles);
  }

  final IRolesRepository _repository;

  Future<void> _onGetRoles(_GetRoles event, Emitter<RolesState> emit) async {
    final usesCase = GetRoles(_repository);
    final params = GetRolesParams(
      userUuid: event.userUuid,
      projectUuid: event.projectUuid,
    );
    emit(RolesState.loading());
    final roles = await usesCase(params);
    emit(RolesState.loaded(roles));
  }

  Future<void> _onDeleteRoles(_DeleteRoles event, Emitter<RolesState> emit) async {
    final useCase = DeleteRolesUseCase(_repository);
    emit(RolesState.loading());
    await useCase(event.listOfParams);
    add(RolesEvent.getRoles());
  }
}
