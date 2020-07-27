import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:uibot/bot/bot_id.dart';
import 'package:uibot/bot/controllers/controller.dart';
import 'package:uibot/bot/models/hidden_instructions.dart';

class Server {
  TeleDart instance;

  Future startBot() async {
    if (instance == null) {
      await initBot();
    }
    stopBot();
    var me = await instance.start();
    print('${me.username} is initialised');
  }

  Future initBot() async {
    instance = TeleDart(Telegram(bot_id), Event());
    var controller = Controller(bot: instance.telegram);
    await controller.loadStories();

    instance
        .onMessage(entityType: 'bot_command', keyword: 'start')
        .listen(controller.processStart);

    instance.onCommand('list_stories').listen(controller.processListStories);

    instance.onMessage().listen((event) {
      print('Received event: ${event.text}');
    });

    instance
        .onMessage()
        .where(controller.catchStoryTitles)
        .listen(controller.processStartStory);

    instance
        .onMessage()
        .where((message) => message.text == "Продовжити")
        .listen(controller.processContinue);

    instance.onMessage().where((message) {
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

  stopBot() {
    if (instance != null) instance.removeLongPolling();
  }
}
