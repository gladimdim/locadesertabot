accessing
processStartStoryForMessage: aMessage
|storyTitle story storyObj array markup|
storyTitle := aMessage text.
story := (stories select: [:each | (each at: #title) = storyTitle]) at: 1.
storyObj := self fetchStoryByMeta: story.
users at: aMessage chat id put: storyObj.

array := { { Dictionary newFrom: {#text -> 'Продовжити'}} }.
markup := Dictionary new.
markup at: 'keyboard' put: array; at: 'resize_keyboard' put: true.
aMessage send: (storyObj currentPage currentText) withReplyMarkup: markup