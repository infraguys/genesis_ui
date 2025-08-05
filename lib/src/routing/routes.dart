// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// part 'routes.g.dart';
// part 'routes/test.dart';
// part 'routes/dashboard_route.dart';

part of 'app_router.dart';

enum AppRoutes {
  /// auth
  signIn,
  signUp,

  /// iam
  users,
  user,
  projects,

  roles,
  createRole,
  organizations,
  createOrganization,
  //
  main,
  monitoring,
  vpn,
}
