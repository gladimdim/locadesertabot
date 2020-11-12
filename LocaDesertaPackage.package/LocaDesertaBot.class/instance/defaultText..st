action
defaultText: aMessage
(self allStoriesTitles contains: [:each | each = aMessage text]) ifTrue: [ self processStartStoryForMessage: aMessage].

aMessage text = 'Продовжити' ifTrue: [ self processContinueForMessage: aMessage ]