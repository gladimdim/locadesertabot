accessing
processStartStoryForMessage: aMessage
|storyTitle story storyObj|
storyTitle := aMessage text.

story := (stories select: [:each | storyTitle = (each at: #title)]) at: 1.
storyObj := (self fetchStoryByMeta: story).
aMessage answer: storyTitle