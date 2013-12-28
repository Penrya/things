//
// Parametric mobile base V1
//
// equation: m1*a+0.5*a*q*a*ro = m2*b+0.5*b*q*b*ro
// 
//

length = 37.4;	// distance between endpoint fixtures
hole = 1;		// fixture hole radius

m1 =9.2;		// weigth #1
m2 = 16;		// weigth #2
sy=4;			// y thickness
sz=4;			// z thickness
alt = 4*hole;	// altitude of center fixture

ro=1.320/1000	;		 // gramm/mm^3 of PLA

detail=22; 				// details



q=sy*sz;
s= length*(0.5-1/(1+m1/m2));					 // simple one for heavy weights m1/m2, not used
s2= 0.5*length-(length*m2+0.5*length*length*q*ro)/(m1+m2+length*q*ro); //more exact placement

difference (){
	union(){
		cube ([hole*4+length,sy,sz],center=true);
		translate([s2,alt/2,0]) cube ([hole*4,alt+hole*4,sz],center=true);
		}
translate ([length/2,0,0]) rotate([0,0,30]) cylinder (h=2*sz, r=hole, center=true, $fn=detail); // cut m1 fixture
translate ([-length/2,0,0]) rotate([0,0,30]) cylinder (h=2*sz, r=hole, center=true, $fn=detail); // cut m2 fixture
translate ([s2,alt,0]) rotate([0,0,30]) cylinder (h=2*sz, r=hole, center=true, $fn=detail);  // cut center top fixture
translate ([s2,0,0]) rotate([0,0,30]) cylinder (h=2*sz, r=hole, center=true, $fn=detail);  // cut center bottom fixture

//#translate ([s2,alt+hole*2,0]) rotate([90,00,00]) cylinder (h=4*hole, r=hole, center=true, $fn=detail);
//#translate ([-length/2,-hole*2,0] ) rotate([90,00,00]) cylinder (h=4*hole, r=hole, center=true, $fn=detail);
//#translate ([length/2,-hole*2,0] ) rotate([90,00,00]) cylinder (h=4*hole, r=hole, center=true, $fn=detail);
}
