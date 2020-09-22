import 'dart:convert';

import 'package:gladstoriesengine/gladstoriesengine.dart';
import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/telegram.dart';
import 'package:uibot/bot/models/image_resolver.dart';
import 'package:uibot/bot/models/story_bot.dart';
import 'package:uibot/bot/models/story_user.dart';

class Controller {
  List<StoryUser> users = [];
  final Telegram bot;
  List<Story> stories = [];
  Controller({this.bot});

  processStart(Message message) {
    bot.sendMessage(message.chat.id, 'Привіт, це інтерактивні історії!');
  }

  processListStories(Message message) async {
    await loadStories();
    var titles = stories.map((story) => story.title);
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
    var storyList = json["stories"] as List;
    await Future.forEach(
      storyList,
      (element) async {
        var story = await loadStory(
          element,
        );
        stories.add(story);
      },
    );
    print(stories.length);
  }

  bool catchStoryTitles(Message msg) {
    var titles = stories.map((story) => story.title);
    return titles.contains(msg.text);
  }

  processStartStory(Message msg) async {
    print("Starting the story: ${msg.text}");
    StoryUser currentUser = users.firstWhere(
        (element) => element.username == msg.chat.username,
        orElse: () => null);
    if (currentUser == null) {
      currentUser = StoryUser()..username = msg.chat.username;
      users.add(currentUser);
    }
    var story = stories.where((element) => element.title == msg.text).first;
    currentUser.currentStory = story;
    createResponseForStory(currentUser.currentStory, bot, msg);
  }

  Future<Story> loadStory(Map storyMap) async {
    var fetchStory = await http
        .get("https://locadeserta.com/game/assets/${storyMap["storyPath"]}");
    var story = Story.fromJson(fetchStory.body,
        imageResolver: BackgroundImage.getRandomImageForType);
    return story;
  }

  void processContinue(Message msg) {
    StoryUser currentUser = users.firstWhere(
        (element) => element.username == msg.chat.username,
        orElse: () => null);
    if (currentUser != null) {
      createResponseForStory(currentUser.currentStory, bot, msg);
    } else {
      bot.sendMessage(msg.chat.id, "Спочатку почніть історію: /list");
    }
  }

  processAnswerOption(int index, Message msg) {
    StoryUser currentUser = users.firstWhere(
        (element) => element.username == msg.chat.username,
        orElse: () => null);

    if (currentUser != null)
      createResponseForOption(currentUser.currentStory, bot, msg, index);
  }
}
