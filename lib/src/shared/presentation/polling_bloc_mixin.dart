import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/shared/presentation/polling_controller.dart';

mixin PollingBlocMixin<Event, State> on Bloc<Event, State> {
  final PollingController polling = PollingController();

  @override
  Future<void> close() async {
    polling.dispose();
    return super.close();
  }
}
