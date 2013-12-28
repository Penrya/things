// All measurements are in mm

// You will need to change the following to fit your oven. If you're not sure
// what a particular setting does, try changing it and observing how the model
// changes.
//
dial_diameter = 37;
dial_thickness = 18;
handle_diameter = 20.7;
handle_distance_from_front = 27.9; // needs to be absolutely precise
handle_distance_from_dial = 47;

// Higher values here makes it harder to insert and remove the oven shield. You
// want it to be impossible for the child to remove it but possible for you to
// insert it.
handle_embedding_depth = 1.1;
handle_embedding_sides = 1.1;

rod_diameter = 10;

$fs=.1; // decrease for finer details
$fa=5; // decrease for finer details

// As a final configuration step, you may tweak the translation and rotation
// of the model here.
translate([0,0,0]) rotate([0,0,90]) oven_shield();

////// END OF CONFIGURATION //////


dial_rad = sqrt(pow(dial_diameter/2, 2) + pow(dial_thickness,2));
dial_len = dial_diameter;

handle_rad = handle_diameter / 2;
handle_hole_height = handle_distance_from_front + handle_diameter/2;

// rad^2 = (rad - emb)^2 + (x/2)^2, solved for x
handle_emb_length =
	2*sqrt( pow(handle_rad,2) - pow(handle_rad - handle_embedding_depth, 2));

wall_thickness = dial_rad * 0.1;
big_rad = dial_rad + wall_thickness;
eps = 0.01;

module oven_shield() {
	// central rod
	translate([2*eps,-rod_diameter/2,0])
		cube([handle_distance_from_dial + handle_rad,
		      rod_diameter,
		      rod_diameter]);
	
	// handle grip
	translate([handle_distance_from_dial + handle_rad,-rod_diameter/2,0]) {
		difference() {
			hull() {
				translate([-rod_diameter-handle_emb_length,0,0])
					cube([2*(rod_diameter+handle_emb_length),
					      rod_diameter, rod_diameter]);
				translate([-handle_emb_length/2 - handle_embedding_sides,0])
					cube([handle_emb_length + 2*handle_embedding_sides,
					      rod_diameter,
					      handle_distance_from_front + handle_embedding_depth]);
			}
			translate([0,rod_diameter/2,handle_hole_height])
				rotate([90,0,0])
				cylinder(h=rod_diameter+2*eps, r=handle_rad, center=true);
		}
	}
	
	// dial shield
	rotate([0,-90,0])
		difference() {
			union() {
				cylinder(r=big_rad, h=dial_len);
				translate([0,0,-wall_thickness+eps])
					cylinder(r=big_rad, h=wall_thickness);
			}
			translate([0,0,-eps]) cylinder(r=dial_rad, h=dial_len+2*eps);
			translate([-(big_rad+eps), -(big_rad+eps), -eps-wall_thickness])
				cube([big_rad+eps, 2*(big_rad+eps),
				      dial_len+2*eps + wall_thickness]);
		}
}
