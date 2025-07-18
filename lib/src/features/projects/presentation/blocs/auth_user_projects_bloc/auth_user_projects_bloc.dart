import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/use_cases/get_projects_usecase.dart';

part 'auth_user_projects_event.dart';
part 'auth_user_projects_state.dart';

class AuthUserProjectsBloc extends Bloc<AuthUserProjectsEvent, AuthUserProjectsState> {
  AuthUserProjectsBloc(this._projectsRepository) : super(AuthUserProjectsState.initial()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _getProjects(_GetProjectsEvent event, Emitter<AuthUserProjectsState> emit) async {
    final getProjectsUseCase = GetProjectsUseCase(_projectsRepository);
    emit(AuthUserProjectsState.loading());
    final projects = await getProjectsUseCase(GetProjectsParams(userUuid: event.userUuid));
    emit(AuthUserProjectsState.loaded(projects));
  }
}
