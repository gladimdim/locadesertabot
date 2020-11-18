accessing
processOptionForMessage: aMessage
|story answers array markup |
story := self findStoryOrAnswer: aMessage.
story ifNil: [^ nil].
answers := story currentPage nextOptionsText.
array := answers collect: [:answer | {Dictionary newFrom: {#text -> answer}}. ].
markup := Dictionary new.
markup at: 'keyboard' put: array; at: 'resize_keyboard' put: true.
aMessage send: 'Виберіть опцію' withReplyMarkup: markup