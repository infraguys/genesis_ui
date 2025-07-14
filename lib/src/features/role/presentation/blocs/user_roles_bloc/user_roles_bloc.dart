import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/role/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/role/domain/use_cases/get_roles_by_user_uuid_usecase.dart';

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
