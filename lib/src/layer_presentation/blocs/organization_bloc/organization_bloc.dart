import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/create_organization_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/delete_organization_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/get_organization_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/update_organization_usecase.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc(this._repository) : super(OrganizationInitialState()) {
    on(_onGetOrganization);
    on(_onCreateOrganization);
    on(_onUpdateOrganization);
    on(_onDeleteOrganization);
  }

  final IOrganizationsRepository _repository;

  Future<void> _onGetOrganization(_Get event, Emitter<OrganizationState> emit) async {
    final useCase = GetOrganizationUseCase(_repository);
    emit(OrganizationLoadingState());
    final organization = await useCase(event.uuid);
    emit(OrganizationLoadedState(organization));
  }

  Future<void> _onCreateOrganization(_Create event, Emitter<OrganizationState> emit) async {
    final useCase = CreateOrganizationUseCase(_repository);
    try {
      final organization = await useCase(event.params);
      emit(OrganizationCreatedState(organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdateOrganization(_Update event, Emitter<OrganizationState> emit) async {
    final useCase = UpdateOrganizationUseCase(_repository);
    try {
      final organization = await useCase(event.params);
      emit(OrganizationUpdatedState(organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }

  Future<void> _onDeleteOrganization(_Delete event, Emitter<OrganizationState> emit) async {
    final useCase = DeleteOrganizationUseCase(_repository);
    try {
      await useCase(event.organization.uuid);
      emit(OrganizationDeletedState(event.organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }
}
