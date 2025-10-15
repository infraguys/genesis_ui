import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/features/extensions/domain/usecases/get_extensions_usecase.dart';

part 'extensions_event.dart';
part 'extensions_state.dart';

class ExtensionsBloc extends Bloc<ExtensionsEvent, ExtensionsState> {
  ExtensionsBloc(this._repository) : super(ExtensionsInitialState()) {
    on(_onGetExtensions);
  }

  final IExtensionsRepository _repository;

  Future<void> _onGetExtensions(_GetExtensions event, Emitter<ExtensionsState> emit) async {
    final useCase = GetExtensionsUseCase(_repository);
    emit(ExtensionsLoadingState());

    final extensions = await useCase(event.params);
    emit(ExtensionsLoadedState(extensions));
  }
}
