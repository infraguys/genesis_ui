import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._restClient) : super(AppState.init()) {
    on(_onLoading);
  }

  final RestClient _restClient;

  Future<void> _onLoading(_Loading event, Emitter<AppState> emit) async {
    if (kIsWeb) {
      // Веб: внешний конфиг + cache-busting
      final url = 'config/config.json?version=${DateTime.now().millisecondsSinceEpoch}';
      final response = await _restClient.get<Map<String, dynamic>>(url);
    } else {
      throw UnimplementedError();
    }
    // Натив: сначала Documents, потом assets
    //   try {
    //     // dart:io путь к файлу
    //     final dir = await getApplicationDocumentsDirectory(); // path_provider
    //     final file = File('${dir.path}/config.json');
    //     if (await file.exists()) {
    //       return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    //     }
    //   } catch (_) {/* пропускаем и идём к assets */}
    //   final asset = await rootBundle.loadString('assets/config.json');
    //   return jsonDecode(asset) as Map<String, dynamic>;
    // }
  }
}
