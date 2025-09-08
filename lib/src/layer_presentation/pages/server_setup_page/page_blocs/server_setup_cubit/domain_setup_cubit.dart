import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_data/source/local/api_url_dao.dart';

part './domain_setup_state.dart';

class DomainSetupCubit extends Cubit<DomainSetupState> {
  DomainSetupCubit(this._urlDao) : super(DomainSetupState.initial());

  final ApiUrlDao _urlDao;

  Future<void> readApiUrl() async {
    // await _urlDao.deleteApiUrl();
    final url = await _urlDao.readApiUrl();
    if (url != null) {
      emit(DomainSetupState.read(url));
    } else {
      emit(DomainSetupState.empty());
    }
  }

  Future<void> writeApiUrl(String value) async {
    final trimmedValue = value.trim();
    emit(DomainSetupState.loading());
    await _urlDao.writeApiUrl(trimmedValue);
    emit(DomainSetupState.written(trimmedValue));
  }
}
