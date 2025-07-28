import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/domain/use_cases/get_orgaizations_usecase.dart';
import 'package:genesis/src/features/organizations/domain/use_cases/get_organizations_by_user_usecase.dart';

part 'organizations_event.dart';
part 'organizations_state.dart';

class OrganizationsBloc extends Bloc<OrganizationsEvent, OrganizationsState> {
  OrganizationsBloc(this._repository) : super(OrganizationsInitState()) {
    on(_getOrganizationsByUser);
    on(_getOrganizations);
  }

  final IOrganizationsRepository _repository;

  Future<void> _getOrganizations(_GetOrganizations event, Emitter<OrganizationsState> emit) async {
    final useCase = GetOrganizationsUseCase(_repository);
    emit(OrganizationsLoadingState());
    final organizations = await useCase(GetOrganizationsParams());
    emit(OrganizationsLoadedState(organizations));
  }

  Future<void> _getOrganizationsByUser(_GetOrganizationsByUser event, Emitter<OrganizationsState> emit) async {
    final useCase = GetOrganizationsByUserUseCase(_repository);
    emit(OrganizationsLoadingState());
    final organizations = await useCase(event.userUuid);
    emit(OrganizationsLoadedState(organizations));
  }
}
