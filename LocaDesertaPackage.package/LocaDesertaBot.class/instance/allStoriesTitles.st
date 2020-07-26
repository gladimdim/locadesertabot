as yet unclassified
allStoriesTitles
|titles|
titles := self fetchCatalog.
^ titles collect: [:each | each at: #title]