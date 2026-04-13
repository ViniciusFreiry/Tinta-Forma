randomise();

global.ink_power_up = false;
global.run_power_up = false;

global.actual_room = rm_hub_world;
global.player_x = 64;
global.player_y = 544;
global.player_xscale = 1;

function create_my_save() {
	save_game(["ink_power_up", "run_power_up", "actual_room", "player_x", "player_y", "player_xscale"]);
}