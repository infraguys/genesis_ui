import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/params/projects/get_projects_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/projects/get_projects_by_user_usecase.dart';

part 'user_projects_event.dart';
part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
  UserProjectsBloc(this._projectsRepository) : super(UserProjectsState.initial()) {
    on(_getProjects);
  }

  final IProjectsRepository _projectsRepository;

  Future<void> _getProjects(_GetProjects event, Emitter<UserProjectsState> emit) async {
    final useCase = GetProjectsByUserUseCase(_projectsRepository);
    emit(UserProjectsState.loading());

    final projects = await useCase(event.params);
    emit(UserProjectsState.loaded(projects));
  }
}
