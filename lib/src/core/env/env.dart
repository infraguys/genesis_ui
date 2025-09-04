import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class Env {
  static Future<void> loadConfig() async {
    if (kIsWeb) {
      final uri = Uri.base.resolve('config.json?ts=${DateTime.now().millisecondsSinceEpoch}');
      final Response(:data, :statusCode) = await Dio().getUri<Map<String, dynamic>>(
        uri,
        options: Options(
          headers: {'Cache-Control': 'no-cache'},
        ),
      );
      if (data == null) {
        throw Exception('Failed to load config: HTTP $statusCode');
      }
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

  // static void _setConfig(Map<String, dynamic> config) {
  //   _apiUrl = config['api_url'] as String? ?? String.fromEnvironment('api_url');
  //
  // }

  static final _envString = String.fromEnvironment('env', defaultValue: EnvMode.unknown.name);

  static const apiUrl = String.fromEnvironment('api_url');

  // Iam client config
  static const iamClientUuid = String.fromEnvironment('iam_client_uuid');
  static const clientId = String.fromEnvironment('client_id');
  static const clientSecret = String.fromEnvironment('client_secret');
  static const grantType = String.fromEnvironment('grant_type');
  static const ttl = int.fromEnvironment('ttl');
  static const refreshTtl = int.fromEnvironment('refresh_ttl');
  static const scope = String.fromEnvironment('scope');

  static EnvMode mode = switch (_envString) {
    'dev' => EnvMode.dev,
    'stage' => EnvMode.stage,
    'prod' => EnvMode.prod,
    _ => EnvMode.unknown,
  };
}

enum EnvMode {
  dev,
  stage,
  prod,
  unknown;

  bool get isDev => this == EnvMode.dev;

  bool get isProd => this == EnvMode.prod;

  bool get isStage => this == EnvMode.stage;
}
