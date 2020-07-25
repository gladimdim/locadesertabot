*LocaDesertaPackage
sendPhoto: aPhotoUrl to: aChatID
	|dict|
	dict := Dictionary new. 
	dict at: 'chat_id' put: aChatID; at: 'photo' put: aPhotoUrl. 
	self sendPOST: '/sendPhoto' data: dict