action
processContinueForMessage: aMessage
|story|
story := self findStoryOrAnswer: aMessage.
story ifNil: [^ nil].
story currentPage canContinue 
	ifTrue: [
		story currentPage doContinue.
		story currentPage currentNode imageType ifNotNil: [ 
			|imageResolver|
			imageResolver := ImageResolver new.
			self sendPhotoAtURL: (imageResolver stringToUrl: story currentPage currentNode imageType) to: aMessage.
			 ].
		aMessage send: story currentPage currentText withReplyMarkup: self getContinueMarkup.
		"self sendChatMessage: story currentPage currentText to: aMessage chat id printString."
		]
	ifFalse: [ self processOptionForMessage: aMessage].