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
impression_curve = 3;

/* Pig's head shape. The "chin" is ogee-shaped. */
module ogee() {
	difference() {
		union() {
			circle(r=1);
			translate([sqrt(2)/2, -sqrt(2)/2]) square([1, 1]);
		}
		translate([sqrt(2), -sqrt(2)]) {
			circle(1);
			square([1, 1]);
		}
		translate([-1,-1]) square([1,2]);
	}
}

/*
 * The base cylinder of the bottle will be "baselen" long and have "radius".
 * The neck curve will be "curvelen" long.
 */
module asym_bottle(baselen=1, curvelen=1, radius=1) {
	translate([0, sqrt(2)-1]) scale([1,radius]) {
		translate([baselen,0])
		scale([curvelen/sqrt(2), 1])
		ogee();
	
		translate([0,-1]) square([baselen,2]);
	}
}

/*
 * Like rotate_extrude, but instead of making a circle (seen from above)
 * it makes a paper-clip shape (i.e. Nascar-track shape).
 */
module rotate_extrude_long(length, convexity=4) {
	translate([0, length/2, 0]) {
		rotate_extrude(convexity=convexity)
		child();
		
		translate([0,-length,0]) rotate_extrude(convexity=convexity)
		child();
	
		rotate([90,0,0])
		linear_extrude(height=length, convexity=convexity)
		child();
	
		mirror([1,0,0])
		rotate([90,0,0])
		linear_extrude(height=length, convexity=convexity)
		child();
	}
}

//rotate_extrude_long(length=5)
//asym_bottle(baselen = 5, curvelen = 1);

difference() {
	scale([1,1,handle_z])
	difference() {
		translate([0,-handle_y/2,0])
		cube([handle_x, handle_y, 1]);
	
		assign ($fn=400) {
			translate([0,0,-eps]) scale([pot_r,pot_r,1 + 2*eps])
				bite(handle_y / pot_r);
		}
	
	}

	*translate([impression_margin,
	           -handle_y/2 + impression_margin,
	           handle_z - impression_depth])
	cube([handle_x - 2*impression_margin,
	       handle_y - 2*impression_margin,
	       handle_z]);

	translate([21.5 /*TODO*/,
	           0,
	           handle_z + 0.4/*TODO*/])
	rotate_extrude_long(length = 30 /*TODO*/)
	asym_bottle(baselen = (handle_x - impression_margin - 2/*TODO*/*impression_curve) / 2,
	            curvelen = impression_curve,
	            radius = impression_depth);
}

module bite(width) {
	h = sqrt(1 - width*width/4);
	translate([-h, 0, 0])
	  cylinder(1, 1, 1);
}
