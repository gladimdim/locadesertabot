action
processContinueForMessage: aMessage
|story|
story := self findStoryOrAnswer: aMessage.
story ifNil: [^ nil].
story currentPage canContinue 
	ifTrue: [
		story currentPage doContinue.
		aMessage send: story currentPage currentText withReplyMarkup: self getContinueMarkup.
		"self sendChatMessage: story currentPage currentText to: aMessage chat id printString."
		]
	ifFalse: [ self processOptionForMessage: aMessage].