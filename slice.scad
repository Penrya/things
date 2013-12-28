eps = 0.1;

module cropboxes(r, deg, h=1) {
	degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
	if (degn > 180)
		intersection_for(a = [0, 180 - degn])
			rotate(a) translate([-r, 0, -h/2]) cube([r*2, r*2, h]); 
	else
		for(a = [0, 180 - degn])
			rotate(a) translate([-r, 0, -h/2]) cube([r*2, r*2, h]); 
}

module cropsquares(r, deg) {
	degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
	if (degn > 180)
		intersection_for(a = [0, 180 - degn])
			rotate(a) translate([-r, 0, 0]) square(r*2);
	else
		for(a = [0, 180 - degn])
			rotate(a) translate([-r, 0, 0]) square(r*2);
}

module slice(r = 10, deg = 30) {
	difference() {
		circle(r);
		cropsquares(r, deg);
	}
}

*slice(20, 190);

difference() {
	rotate_extrude(convexity=4) translate([10,0,0]) circle(r=3);
	cropboxes(13, 210, 6+eps);
}
