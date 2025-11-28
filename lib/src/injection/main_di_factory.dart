import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/bootstrap/presentation/blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/features/iam_client/sources/api_url_dao.dart';
import 'package:genesis/src/injection/feat_factories/auth_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/clusters_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/dbaas_factory.dart';
import 'package:genesis/src/injection/feat_factories/extensions_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/nodes_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/organizations_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/permission_bindings_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/permissions_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/projects_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/role_bindings_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/roles_di_factory.dart';
import 'package:genesis/src/injection/feat_factories/users_di_factory.dart';

final class MainDiFactory {
  factory MainDiFactory() => _instance ??= MainDiFactory._();

  MainDiFactory._()
    : users = UsersDiFactory(),
      projects = ProjectsDiFactory(),
      roles = RolesDiFactory(),
      organizations = OrganizationsDiFactory(),
      nodes = NodesDiFactory(),
      permissions = PermissionsDiFactory(),
      roleBindings = RoleBindingsDiFactory(),
      permissionBindings = PermissionBindingsDiFactory(),
      extensions = ExtensionsDiFactory(),
      clusters = ClustersDiFactory(),
      dbaas = DbaasFactory(),
      auth = AuthDiFactory();

  static MainDiFactory? _instance;

  final UsersDiFactory users;
  final ProjectsDiFactory projects;
  final RolesDiFactory roles;
  final OrganizationsDiFactory organizations;
  final NodesDiFactory nodes;
  final PermissionsDiFactory permissions;
  final RoleBindingsDiFactory roleBindings;
  final PermissionBindingsDiFactory permissionBindings;
  final ExtensionsDiFactory extensions;
  final ClustersDiFactory clusters;
  final DbaasFactory dbaas;
  final AuthDiFactory auth;

  RestClient createRestClient(BuildContext context) {
    IBaseStorageClient storage = context.read<ISecureStorageClient>();
    if (kIsWeb && Uri.base.isScheme('http')) {
      storage = context.read<ISimpleStorageClient>();
    }
    return RestClient(storage);
  }

  DomainSetupCubit createDomainSetupCubit(BuildContext context) {
    final dao = ApiUrlDao(context.read<ISimpleStorageClient>());
    return DomainSetupCubit(dao);
  }
}
