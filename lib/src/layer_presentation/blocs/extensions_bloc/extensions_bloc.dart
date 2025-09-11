import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';
import 'package:genesis/src/layer_domain/params/extensions_params/get_extensions_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/extensions_usecases/get_extensions_usecase.dart';

part 'extensions_event.dart';
part 'extensions_state.dart';

class ExtensionsBloc extends Bloc<ExtensionsEvent, ExtensionsState> {
  ExtensionsBloc(this._repository) : super(ExtensionsState.initial()) {
    on(_onGetExtensions);
  }

  final IExtensionsRepository _repository;

  Future<void> _onGetExtensions(_GetExtensions event, Emitter<ExtensionsState> emit) async {
    final useCase = GetExtensionsUseCase(_repository);
    emit(ExtensionsState.loading());

    final extensions = await useCase(event.params);
    emit(ExtensionsState.loaded(extensions));
  }
}
