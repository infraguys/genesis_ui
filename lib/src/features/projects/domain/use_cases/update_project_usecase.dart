import 'package:genesis/src/features/projects/domain/params/update_project_paramas.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';

final class UpdateProjectUseCase {
  UpdateProjectUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(UpdateProjectParams params) async {
    await _repository.updateProject(params);
  }
}
