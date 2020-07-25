*LocaDesertaPackage
sendChatMessage: aMessage to: aChatID withReplyMarkup: aReplyMarkup
	|dict|
	dict := Dictionary new. 
	dict at: 'chat_id' put: aChatID; at: 'text' put: aMessage.
	dict at: 'reply_markup' put: (STONJSON toString: aReplyMarkup).
	self sendPOST: '/sendMessage' data: dict