as yet unclassified
processContinueForMessage: aMessage
|story|
story := users at: aMessage chat id.
story currentPage doContinue.
^ story currentPage currentText