def defineCharacterFields(character):
	character = {'id': character['id'],
								'name': character['name'],
								'description': character['description'],
								'comics_count': character['comics']['available'],
								'series_count': character['series']['available'],
								'stories_count': character['stories']['available'],
								'events_count': character['events']['available']}
	return character