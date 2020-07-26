import 'package:gladstoriesengine/gladstoriesengine.dart';
import 'package:teledart/model.dart';
import 'package:teledart/telegram.dart';

void createResponseForStory(Story story, Telegram bot, Message msg) {
  if (story.canContinue()) {
    var element = story.history.last;
    if (element.imagePath != null) {
      bot.sendPhoto(msg.chat.id, element.imagePath[0]);
    }
    bot.sendMessage(
      msg.chat.id,
      element.text,
      reply_markup: ReplyKeyboardMarkup(
        keyboard: [
          [KeyboardButton(text: "Продовжити")]
        ],
        one_time_keyboard: true,
      ),
    );
    story.doContinue();
  } else {
    var emojis = ["1️⃣", "2️", "3️"];
    var emojiPointer = 0;
    bot.sendMessage(
      msg.chat.id,
      "Виберіть опцію",
      reply_markup: ReplyKeyboardMarkup(
        keyboard: [
          story.currentPage.next
              .map((e) =>
                  KeyboardButton(text: "${emojis[emojiPointer++]}${e.text}"))
              .toList()
        ],
        one_time_keyboard: true,
      ),
    );
  }
}
