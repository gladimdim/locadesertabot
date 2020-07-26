import 'dart:io' show Platform;

import 'package:locadesertabot/controller.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() async {
  final envVars = Platform.environment;

  var teledart = TeleDart(Telegram(envVars['BOT_TOKEN']), Event());
  var controller = Controller(bot: teledart.telegram);
  await controller.loadStories();
  teledart.start().then((me) => print('${me.username} is initialised'));

  teledart
      .onMessage(entityType: 'bot_command', keyword: 'start')
      .listen(controller.processStart);

  teledart.onCommand('list_stories').listen(controller.processListStories);

  teledart.onMessage().listen((event) {
    print('Received event: ${event.text}');
  });

  teledart
      .onMessage()
      .where(controller.catchStoryTitles)
      .listen(controller.processStartStory);
}
