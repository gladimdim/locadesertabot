import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/telegram.dart';

class Controller {
  final Telegram bot;
  List stories;
  Controller({this.bot});

  processStart(Message message) {
    bot.sendMessage(message.chat.id, 'Привіт, це інтерактивні історії!');
  }

  processListStories(Message message) {
    var titles = stories.map((story) => story["title"]);
    bot.sendMessage(
      message.chat.id,
      "Список історій",
      reply_markup: ReplyKeyboardMarkup(
        keyboard: titles.map((text) => [KeyboardButton(text: text)]).toList(),
        one_time_keyboard: true,
      ),
    );
  }

  loadStories() async {
    var response = await http
        .get("https://locadeserta.com/game/assets/assets/story_catalog.json");
    var json = jsonDecode(response.body);
    stories = json["stories"] as List;
  }

  bool catchStoryTitles(Message msg) {
    var titles = stories.map((story) => story["title"]);
    return titles.contains(msg.text);
  }

  processStartStory(Message msg) {
    print("Starting the story: ${msg.text}");
    bot.sendMessage(msg.chat.id, "Початок історії: ${msg.text}");
  }
}
