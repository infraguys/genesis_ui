import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:genesis/src/features/roles/domain/params/get_role_bindings_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/projects/domain/usecases/get_project_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/get_role_bindings_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/get_role_usecase.dart';

part 'user_projects_event.dart';
part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
  UserProjectsBloc({
    required IProjectsRepository projectsRepository,
    required IRoleBindingsRepository roleBindingsRepository,
    required IRolesRepository rolesRepository,
  }) : _projectsRepository = projectsRepository,
       _roleBindingsRepository = roleBindingsRepository,
       _rolesRepository = rolesRepository,
       super(UserProjectsState.initial()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;
  final IRoleBindingsRepository _roleBindingsRepository;
  final IRolesRepository _rolesRepository;

  Future<void> _getProjects(_GetProjects event, Emitter<UserProjectsState> emit) async {
    final getRoleBindingsUseCase = GetRoleBindingsUseCase(_roleBindingsRepository);
    final getProjectUseCase = GetProjectUseCase(_projectsRepository);
    final getRoleUseCase = GetRoleUseCase(_rolesRepository);

    emit(UserProjectsState.loading());

    final Set<({Project project, List<Role> roles})> result = {};

    try {
      var bindings = await getRoleBindingsUseCase(GetRoleBindingsParams(userUUID: event.userUuid));
      bindings = bindings.where((it) => it.projectUUID != null).toList();

      final projectUUIDs = bindings.map((b) => b.projectUUID!).toSet().toList();

      final projects = await Future.wait(
        projectUUIDs.map((uuid) => getProjectUseCase(uuid)),
      );

      // todo: ипсравить projectUUID
      for (final project in projects) {
        final projectsBindings = bindings.where((binding) => binding.projectUUID == project.id).toList();
        final roles = await Future.wait(
          projectsBindings.map((binding) => getRoleUseCase(binding.roleUUID)),
        );
        result.add((project: project, roles: roles));
      }
      emit(UserProjectsState.loaded(result.toList()));
    } on PermissionException catch (e) {
      emit(UserProjectsState.permissionFailure(e.message));
    }
  }
}
