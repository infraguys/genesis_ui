part of './app_theme.dart';

final _navigationDrawerThemeData = NavigationDrawerThemeData(
  backgroundColor: Colors.grey.shade50.withValues(alpha: .99),
  indicatorShape: RoundedRectangleBorder(),
  indicatorColor: Colors.transparent,
  iconTheme: WidgetStateProperty.fromMap({
    WidgetState.selected: IconThemeData(color: Colors.blue),
    WidgetState.any: IconThemeData(color: Colors.grey),
  }),
  labelTextStyle: WidgetStateTextStyle.fromMap({
    WidgetState.selected: TextStyle(color: Colors.blue),
    WidgetState.any: TextStyle(color: Colors.grey),
  }),
);
