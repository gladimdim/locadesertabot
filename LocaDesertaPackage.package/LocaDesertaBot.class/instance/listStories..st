as yet unclassified
listStories: aMessage
|markup array dict dict1|
dict := Dictionary newFrom: { #text->'1' }.
dict1 := Dictionary newFrom: { #text->'2' }.
array := { { dict . dict1 }}.
markup := Dictionary new.
markup at: 'keyboard' put: array.
aMessage send: 'Виберіть історію' withReplyMarkup: markup