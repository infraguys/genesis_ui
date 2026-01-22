import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';
import 'package:genesis/src/features/extensions/domain/usecases/get_extensions_usecase.dart';

part 'extensions_event.dart';
part 'extensions_state.dart';

class ExtensionsBloc extends Bloc<ExtensionsEvent, ExtensionsState> {
  ExtensionsBloc({required GetExtensionsUseCase getExtensionsUseCase})
    : _getExtensionsUseCase = getExtensionsUseCase,
      super(ExtensionsInitialState()) {
    on(_onGetExtensions);
  }

  final GetExtensionsUseCase _getExtensionsUseCase;

  Future<void> _onGetExtensions(_GetExtensions event, Emitter<ExtensionsState> emit) async {
    emit(ExtensionsLoadingState());

    final extensions = await _getExtensionsUseCase(event.params);
    emit(ExtensionsLoadedState(extensions));
  }
}
