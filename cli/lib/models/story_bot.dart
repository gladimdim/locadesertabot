import 'package:gladstoriesengine/gladstoriesengine.dart';
import 'package:locadesertabot/models/hidden_instructions.dart';
import 'package:locadesertabot/models/image_resolver.dart';
import 'package:teledart/model.dart';
import 'package:teledart/telegram.dart';

void createResponseForStory(Story story, Telegram bot, Message msg) {
  var currentImageType = story.currentPage.getCurrentNode().imageType;
  if (currentImageType != null) {
    BackgroundImage.nextRandomForType(currentImageType);
  }
  if (story.canContinue()) {
    var element = story.history.last;
    if (element.imagePath != null) {
      bot.sendPhoto(msg.chat.id, element.imagePath[1]);
    }

    bot.sendMessage(
      msg.chat.id,
      element.text,
      reply_markup: ReplyKeyboardMarkup(
        keyboard: [
          [KeyboardButton(text: "Продовжити")]
        ],
      ),
    );
    story.doContinue();
  } else {
    var emojiPointer = 0;
    bot.sendMessage(
      msg.chat.id,
      "Виберіть опцію",
      reply_markup: ReplyKeyboardMarkup(
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
