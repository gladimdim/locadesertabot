*LocaDesertaPackage
sendPhoto: sUrl
	|aId|	
	aId := (self chat id) printString.
	self bot sendPhoto: sUrl to: aId.