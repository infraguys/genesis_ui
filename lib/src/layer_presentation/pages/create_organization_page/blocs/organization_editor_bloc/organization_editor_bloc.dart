import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/organizations/create_organization_usecase.dart';

part 'organization_editor_event.dart';
part 'organization_editor_state.dart';

class OrganizationEditorBloc extends Bloc<OrganizationEditorEvent, OrganizationEditorState> {
  OrganizationEditorBloc(this._repository) : super(OrganizationEditorState.initial()) {
    on(_onCreateOrganization);
    // on(_onUpdateOrganization);
  }

  final IOrganizationsRepository _repository;

  Future<void> _onCreateOrganization(_CreateOrganization event, Emitter<OrganizationEditorState> emit) async {
    final useCase = CreateOrganizationUseCase(_repository);
    emit(OrganizationEditorState.loading());
    await useCase(event.params);
    emit(OrganizationEditorState.success());
  }
}
