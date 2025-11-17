import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/features/iam_client/sources/api_url_dao.dart';

part './domain_setup_state.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this._urlDao) : super(_InitialState());

  final ApiUrlDao _urlDao;

  Future<void> readApiUrl() async {
    final url = await _urlDao.readApiUrl();
    if (url != null && url.isNotEmpty) {
      emit(DomainSetupReadState(url));
    } else {
      emit(DomainSetupEmptyState());
    }
  }

  Future<void> writeApiUrl(String value) async {
    final trimmedValue = value.trim();
    Env.baseUrl = trimmedValue;

    emit(DomainSetupLoadingState());
    await _urlDao.writeApiUrl(Env.baseUrl);
    emit(DomainSetupWrittenState(trimmedValue));
    emit(DomainSetupReadState(Env.baseUrl));
  }
}
