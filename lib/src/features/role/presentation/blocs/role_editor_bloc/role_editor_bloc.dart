import 'package:flutter_bloc/flutter_bloc.dart';

part 'role_editor_event.dart';
part 'role_editor_state.dart';

class RoleEditorBloc extends Bloc<RoleEditorEvent, RoleEditorState> {
  RoleEditorBloc() : super(RoleEditorState.initial()) {
    on(_onCreateRole);
    on(_onUpdateRole);
  }
}
