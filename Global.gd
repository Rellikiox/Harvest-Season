extends Node


enum CardEnum {
	NONE = -1, DIG_GROUND, PLACE_SPRINKLER, DELETE_TILE, WATERING_CAN, HARVEST_CROP,
	PLANT_POTATO, PLANT_ONION, PLANT_PEAS, PLANT_BEET, PLANT_CABBAGE
}

enum GroundTileEnum {EMPTY = -1, DIRT, SOIL, POTATO, ONION, PEAS, BEET, CABBAGE, SPRINKLER}
enum EffectsEnum {EMPTY = -1, DEAD, WATER_1, WATER_2, WATER_3, WATER_4}
enum UITileEnum {EMPTY = -1, HIGHLIGHT, INVALID}
enum HighlightTileEnum {EMPTY = -1, HIGHLIGHT, INVALID, WATER}


var CROP_POINTS = {
	GroundTileEnum.POTATO: {'max': 3, 'points_per_crop': 2, 'points_if_max': 3},
	GroundTileEnum.ONION: {'max': 2, 'points_per_crop': 3, 'points_if_max': 3},
	GroundTileEnum.PEAS: {'max': 5, 'points_per_crop': 1, 'points_if_max': 10},
	GroundTileEnum.BEET: {'max': 1, 'points_per_crop': 7, 'points_if_max': 0},
	GroundTileEnum.CABBAGE: {'max': 3, 'points_per_crop': 4, 'points_if_max': 2},
}
