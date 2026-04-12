if(target != noone) exit;

other.take_key(id);
index = array_length(other.keys);
target = other;
sprite_index = spr_key;
depth = depth - min(index, 99);