import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

class OrganizationsSelectionBloc extends Cubit<List<Organization>> {
  OrganizationsSelectionBloc() : super(List.empty());

  void onToggle(Organization organization) {
    final updatedOrganizations = List.of(state);
    if (updatedOrganizations.contains(organization)) {
      updatedOrganizations.remove(organization);
    } else {
      updatedOrganizations.add(organization);
    }
    emit(updatedOrganizations);
  }

  void onToggleAll(List<Organization> organizations) {
    if (state.length == organizations.length) {
      emit(List.empty());
    } else {
      emit(organizations);
    }
  }

  void onSetCheckedFromResponse({required Project project, required List<Organization> organizations}) {
    final filteredOrganizations = organizations.where((it) => it.uuid.isEqualTo(project.organizationUUID));
    emit(filteredOrganizations.toList());
  }

  void onClear() => emit(List.empty());
}
