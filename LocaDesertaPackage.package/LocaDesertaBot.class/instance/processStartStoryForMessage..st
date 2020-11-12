accessing
processStartStoryForMessage: aMessage
|storyTitle story storyObj|
storyTitle := aMessage text.
story := (stories select: [:each | (each at: #title) = storyTitle]) at: 1.
storyObj := self fetchStoryByMeta: story.
aMessage answer: (storyObj currentPage currentText)