use <../slice.scad>

$fa = 6;
$fs = 0.5;

module turn(rad_arc, rad_tube, angle) {
	rotate([-90,0,0])
	translate([-rad_arc,0,0])
	difference() {
		rotate_extrude(convexity=2)
			translate([rad_arc,0,0])
			circle(rad_tube);
		cropboxes(rad_arc + rad_tube, angle, 2*rad_tube);
	}
}

module straight(rad_tube, len) {
	cylinder(r=rad_tube, h=len);
}

module straightAnd(rad_tube, len) {
	union() {
		straight(rad_tube, len);
		translate([0,0,len]) child(0);
	}
}

// copy-paste of straightAnd. Argh.
module straightAnd2(rad_tube, len) {
	union() {
		straight(rad_tube, len);
		translate([0,0,len]) child(0);
	}
}

module turnAnd(rad_arc, rad_tube, angle) {
	union() {
		turn(rad_arc, rad_tube, angle);
		translate([-rad_arc,0,0])
		rotate([0,-angle,0])
		translate([rad_arc,0,0])
		child(0);
	}
}

straightAnd(1, 10)
turnAnd(5, 1, 60)
straightAnd2(1, 5);
