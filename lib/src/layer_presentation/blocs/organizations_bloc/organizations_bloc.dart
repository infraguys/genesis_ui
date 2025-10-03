import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/get_organizations_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/delete_organizations_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/get_orgaizations_usecase.dart';

part 'organizations_event.dart';
part 'organizations_state.dart';

class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
  OrganizationsBloc(this._repository) : super(OrganizationsInitialState()) {
    on(_getOrganizations);
    on(_onDeleteOrganizations);
  }

  final IOrganizationsRepository _repository;

  Future<void> _getOrganizations(_Get event, Emitter<OrganizationsState> emit) async {
    final useCase = GetOrganizationsUseCase(_repository);
    emit(OrganizationsLoadingState());
    final organizations = await useCase(event.params);
    emit(OrganizationsLoadedState(organizations));
  }

  Future<void> _onDeleteOrganizations(_Delete event, Emitter<OrganizationsState> emit) async {
    final useCase = DeleteOrganizationsUseCase(_repository);

    final prevState = state;
    emit(OrganizationsLoadingState());
    try {
      await useCase(event.organizations);
      add(OrganizationsEvent.getOrganizations());
    } on PermissionException catch (e) {
      emit(OrganizationsPermissionFailureState(e.message));
      emit(prevState);
    }
  }
}
