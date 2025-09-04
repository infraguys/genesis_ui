import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_roles_by_user_uuid_usecase.dart';

part 'user_roles_event.dart';

part 'user_roles_state.dart';

class UserRolesBloc extends Bloc<UserRolesEvent, UserRolesState> {
  UserRolesBloc(this._repository) : super(UserRolesInit()) {
    on<_GetRoles>(_onGetRoles);
  }

  final IRolesRepository _repository;

  Future<void> _onGetRoles(_GetRoles event, Emitter<UserRolesState> emit) async {
    final useCase = GetRolesByUserUuidUseCase(_repository);
    emit(UserRolesLoading());
    final roles = await useCase(event.userUuid);
    emit(UserRolesLoaded(roles));
  }
}
