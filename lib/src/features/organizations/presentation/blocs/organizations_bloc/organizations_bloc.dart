import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/usecases/delete_organizations_usecase.dart';
import 'package:genesis/src/features/organizations/domain/usecases/get_orgaizations_usecase.dart';

part 'organizations_event.dart';
part 'organizations_state.dart';

class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
  OrganizationsBloc({
    required GetOrganizationsUseCase getOrganizationsUseCase,
    required DeleteOrganizationsUseCase deleteOrganizationsUseCase,
  }) : _getOrganizationsUseCase = getOrganizationsUseCase,
       _deleteOrganizationsUseCase = deleteOrganizationsUseCase,
       super(OrganizationsInitialState()) {
    on(_getOrganizations);
    on(_onDeleteOrganizations);
  }

  final GetOrganizationsUseCase _getOrganizationsUseCase;
  final DeleteOrganizationsUseCase _deleteOrganizationsUseCase;

  Future<void> _getOrganizations(_Get event, Emitter<OrganizationsState> emit) async {
    emit(OrganizationsLoadingState());
    final organizations = await _getOrganizationsUseCase(event.params);
    emit(OrganizationsLoadedState(organizations));
  }

  Future<void> _onDeleteOrganizations(_Delete event, Emitter<OrganizationsState> emit) async {
    final prevState = state;
    emit(OrganizationsLoadingState());
    try {
      await _deleteOrganizationsUseCase(event.organizations);
      add(OrganizationsEvent.getOrganizations());
    } on PermissionException catch (e) {
      emit(OrganizationsPermissionFailureState(e.message));
      emit(prevState);
    }
  }
}
