import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

part 'organizations_selection_event.dart';

class OrganizationsSelectionBloc extends Bloc<OrganizationsSelectionEvent, List<Organization>> {
  OrganizationsSelectionBloc() : super(List.empty()) {
    on(_onToggle);
    on(_onToggleAll);
    on(_onClear);
  }

  void _onToggle(_Toggle event, Emitter<List<Organization>> emit) {
    final updatedOrganizations = List.of(state);
    if (updatedOrganizations.contains(event.organization)) {
      updatedOrganizations.remove(event.organization);
    } else {
      updatedOrganizations.add(event.organization);
    }
    emit(updatedOrganizations);
  }

  void _onToggleAll(_ToggleAll event, Emitter<List<Organization>> emit) {
    if (state.length == event.organizations.length) {
      emit(List.empty());
    } else {
      emit(event.organizations);
    }
  }

  void _onClear(_Clear _, Emitter<List<Organization>> emit) {
    emit(List.empty());
  }
}
