import 'dart:io' show Platform;

import 'package:locadesertabot/bot/server.dart';

void main() async {
  final envVars = Platform.environment;
  final bot_token = envVars['BOT_TOKEN'];
  print("Bot token: $bot_token");
  final server = Server(bot_token);

  server.startBot();
}
