import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/projects/create_project_params.dart';
import 'package:genesis/src/layer_domain/params/projects/edit_project_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/create_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/delete_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/edit_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/get_project_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/create_role_bindings_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required IProjectsRepository projectsRepository,
    required IRoleBindingsRepository roleBindingsRepository,
  }) : _projectsRepository = projectsRepository,
       _roleBindingsRepository = roleBindingsRepository,
       super(ProjectInitialState()) {
    on(_onCreateProject);
    on(_onDeleteProject);
    on(_onUpdateProject);
    on(_onGetProject);
  }

  final IProjectsRepository _projectsRepository;
  final IRoleBindingsRepository _roleBindingsRepository;

  Future<void> _onGetProject(_GetProject event, Emitter<ProjectState> emit) async {
    final useCase = GetProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());
    final project = await useCase(event.uuid);
    emit(ProjectLoadedState(project));
  }

  Future<void> _onCreateProject(_Create event, Emitter<ProjectState> emit) async {
    final createProjectUseCase = CreateProjectUseCase(_projectsRepository);
    final createRoleBindingUseCase = CreateRoleBindingsUseCase(_roleBindingsRepository);
    emit(ProjectLoadingState());

    final createdProject = await createProjectUseCase(
      CreateProjectParams(
        name: event.name,
        description: event.description,
        organizationUuid: event.organizationUUID,
      ),
    );

    if (event.userUUID != null) {
      final listOfParams = event.roles.map(
        (role) => CreateRoleBindingParams(
          userUUID: event.userUUID!,
          roleUUID: role.uuid,
          projectUUID: createdProject.uuid,
        ),
      );
      await createRoleBindingUseCase(listOfParams.toList());
    }

    emit(ProjectCreatedState(createdProject));
  }

  Future<void> _onDeleteProject(_Delete event, Emitter<ProjectState> emit) async {
    final useCase = DeleteProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());
    await useCase(event.project.uuid);
    emit(ProjectDeletedState(event.project));
  }

  Future<void> _onUpdateProject(_Update event, Emitter<ProjectState> emit) async {
    final useCase = EditProjectUseCase(_projectsRepository);
    emit(ProjectLoadingState());

    final params = EditProjectParams(
      uuid: event.uuid,
      name: event.name,
      description: event.description,
      organizationUUID: event.organizationUUID,
      status: event.status,
    );
    final updatedProject = await useCase(params);
    emit(ProjectUpdatedState(updatedProject));
  }
}
