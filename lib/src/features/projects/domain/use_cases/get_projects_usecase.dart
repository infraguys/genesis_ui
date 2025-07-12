import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class GetProjectsUseCase {
  const GetProjectsUseCase(this._projectsRepository);

  final IProjectsRepository _projectsRepository;

  Future<List<Project>> call() async {
    return await _projectsRepository.getProjects();
  }
}
