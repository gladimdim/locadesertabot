action
processContinueForMessage: aMessage
|story|
story := users at: aMessage chat id ifAbsent: [aMessage answer: 'Спочатку виберіть історію'. ^ nil].
story currentPage doContinue.
self sendChatMessage: story currentPage currentText to: aMessage chat id printString