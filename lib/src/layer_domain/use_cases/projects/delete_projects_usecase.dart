import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class DeleteProjectsUseCase {
  DeleteProjectsUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(List<Project> project) async {
    final uuids = project.map((project) => project.uuid);
    await Future.wait(uuids.map(_repository.deleteProject));
  }
}
