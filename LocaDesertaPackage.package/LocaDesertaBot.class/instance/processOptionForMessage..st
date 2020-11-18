accessing
processOptionForMessage: aMessage
|story answers array markup |
story := users at: aMessage chat id ifAbsent: [aMessage answer: 'Спочатку виберіть історію'. ^ nil].
answers := story currentPage nextOptionsText.
array := answers collect: [:answer | {Dictionary newFrom: {#text -> answer}}. ].
markup := Dictionary new.
markup at: 'keyboard' put: { array }; at: 'resize_keyboard' put: true.
aMessage send: 'Виберіть опцію' withReplyMarkup: markup