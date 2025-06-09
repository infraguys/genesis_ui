import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum NavigationItem {
  dashboard(iconData: Icons.dashboard_outlined),
  users(iconData: Icons.person_outlined),
  nodes(iconData: Icons.computer_outlined),
  vpns(iconData: Icons.vpn_key_outlined),
  ;

  const NavigationItem({required this.iconData});
  final IconData iconData;
  String get label => name.pascalCase;
}
