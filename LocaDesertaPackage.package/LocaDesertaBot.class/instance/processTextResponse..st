accessing
processTextResponse: aMessage
|story answers input|
input := aMessage text.
story := self findStoryOrAnswer: aMessage.
story ifNil: [ ^ nil ].
story currentPage canContinue ifTrue: [ ^ nil ].
answers := story currentPage nextOptionsText.
(answers anySatisfy: [:each | each = input]) ifFalse: [ ^ nil ].
story goToNextPage: input.

aMessage send: story currentPage currentText withReplyMarkup: self getContinueMarkup.