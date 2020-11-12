initialization
initialize

super initialize .
stories := self fetchCatalog.
self registerCommand: #slashListStories: to: '/list'.
self registerCommand: #slashHelp: to: '/help'