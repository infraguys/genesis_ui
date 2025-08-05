import 'package:flutter_bloc/flutter_bloc.dart';

part 'organization_editor_event.dart';
part 'organization_editor_state.dart';

class OrganizationEditorBloc extends Bloc<OrganizationEditorEvent, OrganizationEditorState> {
  OrganizationEditorBloc() : super(OrganizationEditorState.initial()) {
    on(_onCreateOrganization);
    // on(_onUpdateOrganization);
  }

  Future<void> _onCreateOrganization(_CreateOrganization event, Emitter<OrganizationEditorState> emit) async {
    emit(OrganizationEditorState.loading());
    emit(OrganizationEditorState.success());
  }
}
