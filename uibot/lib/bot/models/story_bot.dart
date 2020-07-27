import 'package:gladstoriesengine/gladstoriesengine.dart';
import 'package:teledart/model.dart';
import 'package:teledart/telegram.dart';
import 'package:uibot/bot/models/hidden_instructions.dart';
import 'package:uibot/bot/models/image_resolver.dart';

void createResponseForStory(Story story, Telegram bot, Message msg) async {
  var currentImageType = story.currentPage.getCurrentNode().imageType;
  if (currentImageType != null) {
    BackgroundImage.nextRandomForType(currentImageType);
  }
  var element = story.history.last;
  if (story.currentPage.isTheEnd() && !story.canContinue()) {
    bot.sendMessage(msg.chat.id, element.text);
    bot.sendMessage(msg.chat.id,
        "Кінець! Введіть /list_stories, щоб вибрати наступну історію!");
    return;
  }

  if (story.canContinue()) {
    if (element.imagePath != null) {
      bot.sendPhoto(msg.chat.id, element.imagePath[1]);
    }

    bot.sendMessage(
      msg.chat.id,
      element.text,
      reply_markup: ReplyKeyboardMarkup(
        resize_keyboard: true,
        keyboard: [
          [KeyboardButton(text: "Продовжити")]
        ],
      ),
    );
    story.doContinue();
  } else {
    var emojiPointer = 0;
    await bot.sendMessage(msg.chat.id, element.text);
    bot.sendMessage(
      msg.chat.id,
      "Виберіть опцію",
      reply_markup: ReplyKeyboardMarkup(
        resize_keyboard: true,
        keyboard: story.currentPage.next
            .map((e) =>
                [KeyboardButton(text: "${emojis[emojiPointer++]} ${e.text}")])
            .toList(),
        one_time_keyboard: true,
      ),
    );
  }
}

void createResponseForOption(
    Story story, Telegram bot, Message msg, int index) {
  PageNext next = story.currentPage.next[index];
  story.goToNextPage(next);

  createResponseForStory(story, bot, msg);
}
