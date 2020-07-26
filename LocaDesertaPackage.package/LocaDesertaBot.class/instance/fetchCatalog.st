as yet unclassified
fetchCatalog
|catalog cat|
catalog := ZnClient new get: 'https://locadeserta.com/game/assets/assets/story_catalog.json'.
cat := STONJSON fromString: catalog.
^ cat at: #stories