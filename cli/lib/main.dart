import 'dart:convert';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() {
  final envVars = Platform.environment;

  var teledart = TeleDart(Telegram(envVars['BOT_TOKEN']), Event());

  teledart.start().then((me) => print('${me.username} is initialised'));

  teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
      (message) => teledart.telegram
          .sendMessage(message.chat.id, 'Привіт, це інтерактивні історії!'));

  teledart
      .onMessage(entityType: 'bot_command', keyword: 'list_stories')
      .listen((message) async {
    var response = await http
        .get("https://locadeserta.com/game/assets/assets/story_catalog.json");
    var json = jsonDecode(response.body);
    var stories = json["stories"] as List;
    var titles = stories.map((story) => story["title"]);
    teledart.telegram.sendMessage(
      message.chat.id,
      "Список історій",
      reply_markup: ReplyKeyboardMarkup(
        keyboard: titles.map((text) => [KeyboardButton(text: text)]).toList(),
        one_time_keyboard: true,
      ),
    );
  });
}
