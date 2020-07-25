accessing
allStoriesTitles
|stories|
stories := self fetchCatalog.
^stories collect: [:each | each at: #title]