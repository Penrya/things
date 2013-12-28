eps=0.01;

module generator() {
	hull() {
		translate([0,0,eps/2]) cube([5,2,eps], center=true);
		translate([0,0,2]) cube([.9*5,.9*2,eps], center=true);
	}
}

generator();