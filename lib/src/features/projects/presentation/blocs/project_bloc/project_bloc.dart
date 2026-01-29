import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/create_project_params.dart';
import 'package:genesis/src/features/projects/domain/params/edit_project_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/delete_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/get_project_usecase.dart';
import 'package:genesis/src/features/projects/domain/usecases/update_project_usecase.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_binding_params.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/usecases/create_role_bindings_usecase.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required GetProjectUseCase getProjectUseCase,
    required CreateProjectUseCase createProjectUseCase,
    required UpdateProjectUseCase updateProjectUseCase,
    required DeleteProjectUseCase deleteProjectUseCase,
    required IRoleBindingsRepository roleBindingsRepository,
  }) : _getProjectUseCase = getProjectUseCase,
       _createProjectUseCase = createProjectUseCase,
       _updateProjectUseCase = updateProjectUseCase,
       _deleteProjectUseCase = deleteProjectUseCase,
       _roleBindingsRepository = roleBindingsRepository,
       super(ProjectInitialState()) {
    on(_onCreateProject);
    on(_onDeleteProject);
    on(_onUpdateProject);
    on(_onGetProject);
  }

  final IRoleBindingsRepository _roleBindingsRepository;
  final GetProjectUseCase _getProjectUseCase;
  final CreateProjectUseCase _createProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;

  Future<void> _onGetProject(_GetProject event, Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    final project = await _getProjectUseCase(event.uuid);
    emit(ProjectLoadedState(project));
  }

  Future<void> _onCreateProject(_Create event, Emitter<ProjectState> emit) async {
    final createRoleBindingUseCase = CreateRoleBindingsUseCase(_roleBindingsRepository);
    emit(ProjectLoadingState());

    final createdProject = await _createProjectUseCase(
      CreateProjectParams(
        name: event.name,
        description: event.description,
        organizationID: event.organizationID,
      ),
    );

    if (event.userID != null) {
      final listOfParams = event.roles.map(
        (role) => CreateRoleBindingParams(
          userID: event.userID!,
          roleID: role.uuid,
          projectID: createdProject.id,
        ),
      );
      await createRoleBindingUseCase(listOfParams.toList());
    }

    emit(ProjectCreatedState(createdProject));
  }

  Future<void> _onDeleteProject(_Delete event, Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    await _deleteProjectUseCase(event.project.id);
    emit(ProjectDeletedState(event.project));
  }

  Future<void> _onUpdateProject(_Update event, Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    final updatedProject = await _updateProjectUseCase(event.params);
    emit(ProjectUpdatedState(updatedProject));
  }
}
