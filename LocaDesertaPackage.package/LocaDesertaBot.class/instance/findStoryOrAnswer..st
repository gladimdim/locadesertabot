as yet unclassified
findStoryOrAnswer: aMessage
|story|
story := users at: aMessage chat id ifAbsent: [aMessage answer: 'Спочатку виберіть історію'. ^ nil].
^ story