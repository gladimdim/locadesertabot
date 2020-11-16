accessing
slashListStories: aMessage
|markup array|
array := self allStoriesTitles collect: [:each | { Dictionary newFrom: {#text -> each}}].


markup := Dictionary new.
markup at: 'keyboard' put: array.
aMessage send: 'Виберіть історію' withReplyMarkup: markup