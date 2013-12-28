$fs=.2;

module base() {
	hull() {
	  translate([-4,-4,0]) cube([8,8,.5]);
	  cylinder(h=2, r=1);
	}
	cylinder(h=15, r=1);
}

base();