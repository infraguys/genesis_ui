import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/domain/usecases/create_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/delete_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/get_organization_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/update_organization_usecase.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc({
    required GetOrganizationUseCase getOrganizationUseCase,
    required CreateOrganizationUseCase createOrganizationUseCase,
    required UpdateOrganizationUseCase updateOrganizationUseCase,
    required DeleteOrganizationUseCase deleteOrganizationUseCase,
  }) : _getOrganizationUseCase = getOrganizationUseCase,
       _createOrganizationUseCase = createOrganizationUseCase,
       _updateOrganizationUseCase = updateOrganizationUseCase,
       _deleteOrganizationUseCase = deleteOrganizationUseCase,
       super(OrganizationInitialState()) {
    on(_onGetOrganization);
    on(_onCreateOrganization);
    on(_onUpdateOrganization);
    on(_onDeleteOrganization);
  }

  final GetOrganizationUseCase _getOrganizationUseCase;
  final CreateOrganizationUseCase _createOrganizationUseCase;
  final UpdateOrganizationUseCase _updateOrganizationUseCase;
  final DeleteOrganizationUseCase _deleteOrganizationUseCase;

  Future<void> _onGetOrganization(_Get event, Emitter<OrganizationState> emit) async {
    emit(OrganizationLoadingState());
    final organization = await _getOrganizationUseCase(event.id);
    emit(OrganizationLoadedState(organization));
  }

  Future<void> _onCreateOrganization(_Create event, Emitter<OrganizationState> emit) async {
    try {
      final organization = await _createOrganizationUseCase(event.params);
      emit(OrganizationCreatedState(organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }

  Future<void> _onUpdateOrganization(_Update event, Emitter<OrganizationState> emit) async {
    try {
      final organization = await _updateOrganizationUseCase(event.params);
      emit(OrganizationUpdatedState(organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }

  Future<void> _onDeleteOrganization(_Delete event, Emitter<OrganizationState> emit) async {
    try {
      await _deleteOrganizationUseCase(event.organization.id);
      emit(OrganizationDeletedState(event.organization));
    } on PermissionException catch (e) {
      emit(OrganizationPermissionFailureState(e.message));
    }
  }
}
