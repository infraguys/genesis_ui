import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/params/get_projects_params.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/domain/use_cases/get_projects_usecase.dart';

part 'user_projects_event.dart';
part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
  UserProjectsBloc(this._projectsRepository) : super(UserProjectsState.init()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _getProjects(_GetProjects event, Emitter<UserProjectsState> emit) async {
    final getProjectsUseCase = GetProjectsUseCase(_projectsRepository);
    emit(UserProjectsState.loading());
    final params = GetProjectsParams(userUuid: event.userUuid);

    final projects = await getProjectsUseCase(params);
    emit(UserProjectsState.loaded(projects));
  }
}
