eps=0.01;
$fs=0.2;

module wing() {
	hull() {
      // closest to base
		scale([1,1,.5]) rotate([0,-90,0]) translate([.4,0])
	      cylinder(r=0.4,h=eps);
      // middle of wing
		translate([4,.25]) cylinder(r=.75,h=eps);
      //  tip of wing
		translate([8,0,1/8]) sphere(1/8, $fn=16);
	}
}

module wings() {
	for (i = [0:2]) {
	  rotate([0,0,i * 360/3]) translate([.5,0]) wing();
	}
	
	hull() {
	  cylinder(r=.75, h=.75);
	  translate([0,0,1]) sphere(r=.5);
	}
}

wings();
