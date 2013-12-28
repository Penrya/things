$fs=.1; // decrease for finer details
$fa=10; // decrease for finer details

eps = 0.1;

// TODO: use as basis for plateR.
module rodR(len) {
	hull() {
		sphere(1);
		translate([len,0,0]) sphere(1);
	}
}

pot_r = 300;
handle_x = 40;
handle_y = 80;
handle_z =  8;
impression_depth = 2;
impression_margin = 10;

module asym_bottle(baselen=2) {
	translate([0, sqrt(2)-1]) {
		translate([baselen,0,0]) difference() {
			union() {
				circle(r=1);
				translate([sqrt(2)/2, -sqrt(2)/2]) square([baselen, 1]);
			}
			translate([sqrt(2), -sqrt(2)]) {
				circle(1);
				square([baselen, 1]);
			}
		}
	
		translate([0,-1]) square([baselen,2]);
	}
}

module rotate_extrude_long(length, convexity=4) {
	rotate_extrude(convexity=convexity) {
		child();
	}
	
	translate([0,-length,0]) rotate_extrude(convexity=convexity) {
		child();
	}

	rotate([90,0,0])
	linear_extrude(height=length, convexity=convexity) {
		child();
	}

	mirror([1,0,0])
	rotate([90,0,0])
	linear_extrude(height=length, convexity=convexity) {
		child();
	}

}

rotate_extrude_long(length=2)
asym_bottle(1.8);

*difference() {
	scale([1,1,handle_z])
	difference() {
		translate([0,-handle_y/2,0])
		cube([handle_x, handle_y, 1]);
	
		assign ($fn=400) {
			translate([0,0,-eps]) scale([pot_r,pot_r,1 + 2*eps])
				bite(handle_y / pot_r);
		}
	
	}

	translate([impression_margin,
	           -handle_y/2 + impression_margin,
	           handle_z - impression_depth])
	minkowski() {
		cube([handle_x - 2*impression_margin,
		       handle_y - 2*impression_margin,
		       handle_z]);
		sphere(impression_depth/2);
	}
}

module bite(width) {
	h = sqrt(1 - width*width/4);
	translate([-h, 0, 0])
	  cylinder(1, 1, 1);
}
