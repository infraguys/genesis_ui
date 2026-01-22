import 'package:flutter/widgets.dart';
import 'package:genesis/src/injection/main_di_factory.dart';

class DiScope extends InheritedWidget {
  const DiScope._({required super.child, required this.diFactory, super.key});

  const DiScope.provide({required Widget child, required MainDiFactory diFactory, Key? key})
    : this._(child: child, diFactory: diFactory, key: key);

  final MainDiFactory diFactory;

  static MainDiFactory of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DiScope>();
    assert(scope != null, 'DiScope.provide was not found above in the widget tree');
    return scope!.diFactory;
  }

  @override
  bool updateShouldNotify(covariant DiScope oldWidget) => false;
}
