use <../slice.scad>

$fa = 6;
$fs = 0.5;

total_width = 60;
arc_thickness = 5;
rad_tubes = 1;

module arc180(radius, thickness) {
	difference() {
		circle(radius);
		circle(radius - thickness);
		translate([-radius,0,0]) square(2*radius);
	}
}

linear_extrude(height=rad_tubes*2, convexity=4, center=true)
	difference() {
		arc180(total_width / 2, arc_thickness);
		intersection() {
			arc180(total_width / 2 - arc_thickness / 3, arc_thickness / 3);
			translate([-total_width, -total_width/20, 0])
				square(2*total_width);
		}
	}

/*
 ___
/   \
|   |
    |
   /
   |
*/