accessing
fetchStoryByMeta: aStoryMeta
|path story|
path := 'https://locadeserta.com/game/assets/' , (aStoryMeta at: #storyPath).
story := ZnClient new get: path.
^ Story fromJsonString: story