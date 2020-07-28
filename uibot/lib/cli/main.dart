import 'dart:io' show Platform;

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:uibot/bot/bot_id.dart';
import 'package:uibot/bot/controllers/controller.dart';
import 'package:uibot/bot/models/hidden_instructions.dart';

void main() async {
  final envVars = Platform.environment;

  var teledart = TeleDart(Telegram(bot_id), Event());
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

  teledart
      .onMessage()
      .where((message) => message.text == "Продовжити")
      .listen(controller.processContinue);

  teledart.onMessage().where((message) {
    var emoji = emojis.firstWhere((element) => message.text.contains(element),
        orElse: () => null);
    return emoji != null;
  }).map((event) {
    var emoji = emojis.firstWhere((element) => event.text.contains(element));
    return [emojis.indexOf(emoji), event];
  }).listen((data) {
    controller.processAnswerOption(data[0], data[1]);
  });
}
