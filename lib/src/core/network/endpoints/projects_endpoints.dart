import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

abstract class ProjectsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/projects/');
  }

  static Endpoint item(ProjectID id) {
    return Endpoint.withCorePrefix('/iam/projects/$id');
  }
}
