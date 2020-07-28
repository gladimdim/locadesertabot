import 'dart:io' show Platform;

import 'package:locadesertabot/bot/server.dart';

void main() async {
  final envVars = Platform.environment;
  final server = Server();

  server.startBot();
}
