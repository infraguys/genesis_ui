import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/create_organization_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/delete_organization_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/update_organization_usecase.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc(this._repository) : super(OrganizationState.initial()) {
    on(_onCreateOrganization);
    on(_onUpdateOrganization);
    on(_onDeleteOrganization);
  }

  final IOrganizationsRepository _repository;

  Future<void> _onCreateOrganization(_Create event, Emitter<OrganizationState> emit) async {
    final useCase = CreateOrganizationUseCase(_repository);
    emit(OrganizationState.loading());
    await useCase(event.params);
    emit(OrganizationState.created());
  }

  Future<void> _onUpdateOrganization(_Update event, Emitter<OrganizationState> emit) async {
    final useCase = UpdateOrganizationUseCase(_repository);
    emit(OrganizationState.loading());
    final organization = await useCase(event.params);
    emit(OrganizationState.updated(organization));
  }

  Future<void> _onDeleteOrganization(_Delete event, Emitter<OrganizationState> emit) async {
    final useCase = DeleteOrganizationUseCase(_repository);
    emit(OrganizationState.loading());
    await useCase(event.organization.uuid);
    emit(OrganizationState.deleted(event.organization));
  }
}
