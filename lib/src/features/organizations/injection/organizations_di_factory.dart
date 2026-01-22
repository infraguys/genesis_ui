import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/organizations/data/repositories/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/domain/usecases/create_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/delete_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/delete_organizations_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/get_orgaizations_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/get_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/update_organization_usecase.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_selection_cubit/organizations_selection_cubit.dart';

final class OrganizationsDiFactory {
  /// Repositories
  ///
  OrganizationsRepository makeOrganizationsRepository(BuildContext context) {
    final organizationsApi = OrganizationsApi(context.read<RestClient>());
    return OrganizationsRepository(organizationsApi);
  }

  /// Blocs
  ///
  OrganizationBloc makeOrganizationBloc(BuildContext context) {
    final repository = context.read<IOrganizationsRepository>();
    return OrganizationBloc(
      getOrganizationUseCase: GetOrganizationUseCase(repository),
      createOrganizationUseCase: CreateOrganizationUseCase(repository),
      updateOrganizationUseCase: UpdateOrganizationUseCase(repository),
      deleteOrganizationUseCase: DeleteOrganizationUseCase(repository),
    );
  }

  OrganizationsBloc makeOrganizationsBloc(BuildContext context) {
    final repository = context.read<IOrganizationsRepository>();
    return OrganizationsBloc(
      getOrganizationsUseCase: GetOrganizationsUseCase(repository),
      deleteOrganizationsUseCase: DeleteOrganizationsUseCase(repository),
    );
  }

  OrganizationsSelectionCubit makeOrganizationSelectionCubit(BuildContext context) {
    return OrganizationsSelectionCubit();
  }
}
