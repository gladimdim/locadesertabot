accessing
slashListStories: aMessage
|markup array dict dict1|
array := self allStoriesTitles collect: [:each | { Dictionary newFrom: {#text -> each}}].


markup := Dictionary new.
markup at: 'keyboard' put: array.
aMessage send: 'Виберіть історію' withReplyMarkup: markup