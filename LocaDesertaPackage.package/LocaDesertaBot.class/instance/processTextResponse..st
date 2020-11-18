as yet unclassified
processTextResponse: aMessage
|story answers input|
input := aMessage text.
story := self findStoryOrAnswer: aMessage.
story ifNil: [ ^ nil ].
story currentPage canContinue ifTrue: [ ^ nil ].
answers := story currentPage nextOptionsText.
(answers contains: [:each | each = input]) ifFalse: [ ^ nil ].
story goToNextPage: input.
story currentPage doContinue.
self processContinueForMessage: aMessage