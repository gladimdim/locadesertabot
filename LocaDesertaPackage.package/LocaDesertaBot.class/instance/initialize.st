initialization
initialize

super initialize .
stories := self fetchCatalog.
users := Dictionary new.
self registerCommand: #slashListStories: to: '/list'.
self registerCommand: #slashHelp: to: '/help'