as yet unclassified
slashListStories: aMessage
|markup array dict dict1|
array := self stories collect: [:each | { Dictionary newFrom: {#text -> each}}].
dict := Dictionary newFrom: { #text->'5' }.
dict1 := Dictionary newFrom: { #text->'4' }.

markup := Dictionary new.
markup at: 'keyboard' put: array.
aMessage send: 'Виберіть історію' withReplyMarkup: markup