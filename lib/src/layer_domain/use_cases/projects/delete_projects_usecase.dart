import 'package:genesis/src/layer_domain/params/projects/delete_project_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';

final class DeleteProjectsUseCase {
  DeleteProjectsUseCase(this._repository);

  final IProjectsRepository _repository;

  Future<void> call(List<DeleteProjectParams> listOfParams) async {
    await Future.wait(
      listOfParams.map((params) => _repository.deleteProject(params)),
    );
  }
}
