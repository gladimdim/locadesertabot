action
defaultText: aMessage
(self allStoriesTitles contains: [:each | each = aMessage text]) ifTrue: [ self processStartStoryForMessage: aMessage] ifFalse: [aMessage answer: 'No']