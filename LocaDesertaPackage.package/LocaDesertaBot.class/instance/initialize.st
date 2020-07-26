initialization
initialize
super initialize .
stories := self allStoriesTitles.
self registerCommand: #slashListStories: to: '/list_stories' 