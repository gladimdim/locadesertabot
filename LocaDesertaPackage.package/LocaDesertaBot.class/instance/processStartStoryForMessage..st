accessing
processStartStoryForMessage: aMessage
|storyTitle story storyObj|
storyTitle := aMessage text.
story := (stories select: [:each | (each at: #title) = storyTitle]) at: 1.
storyObj := self fetchStoryByMeta: story.
users at: aMessage chat id put: storyObj.
aMessage answer: (storyObj currentPage currentText)