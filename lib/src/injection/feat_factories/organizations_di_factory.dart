import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/organizations/data/repositories/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';

final class OrganizationsDiFactory {
  /// Repositories

  OrganizationsRepository createOrganiztionsRepository(BuildContext context) {
    final organizationsApi = OrganizationsApi(context.read<RestClient>());
    return OrganizationsRepository(organizationsApi);
  }

  /// Blocs

  OrganizationsBloc createOrganizationsBloc(BuildContext context) {
    final repository = context.read<IOrganizationsRepository>();
    return OrganizationsBloc(repository);
  }
}
