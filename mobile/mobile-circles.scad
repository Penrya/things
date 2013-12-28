//
// Parametric mobile base
// Based on http://www.thingiverse.com/thing:22958 by Ablapo.
//
// equation: m1*a+0.5*a*q*a*ro = m2*b+0.5*b*q*b*ro
// 
//

length = 37.4;	// distance between endpoint fixtures
hole = 0.5;		// fixture hole radius
ends = 2.0;    // end circle radius

m1 =9.2;		// weigth #1
m2 = 16;		// weigth #2
sy=2;			// y thickness
sz=1;			// z thickness
alt = 2;	// altitude of center fixture

ro=1.08/1000	;		 // gramm/mm^3 of ABS

detail=22; 				// details



q=sy*sz;
s= length*(0.5-1/(1+m1/m2));					 // simple one for heavy weights m1/m2, not used
s2= 0.5*length-(length*m2+0.5*length*length*q*ro)/(m1+m2+length*q*ro); //more exact placement

difference (){
	union(){
		cube ([hole*4+length,sy,sz],center=true);
		// center circle
		translate ([s2,alt,0]) rotate([0,0,30])
			cylinder (h=sz, r=ends, center=true, $fn=detail);
		// m1 circle
		translate ([length/2,0,0]) rotate([0,0,30])
			cylinder (h=sz, r=ends, center=true, $fn=detail);
		// m2 circle
		translate ([-length/2,0,0]) rotate([0,0,30])
			cylinder (h=sz, r=ends, center=true, $fn=detail);
	}
	// cut m1 fixture
	translate ([length/2,0,0]) rotate([0,0,30])
		cylinder (h=2*sz, r=hole, center=true, $fn=detail);
	// cut m2 fixture
	translate ([-length/2,0,0]) rotate([0,0,30])
		cylinder (h=2*sz, r=hole, center=true, $fn=detail);
	// cut center top fixture
	translate ([s2,alt,0]) rotate([0,0,30])
		cylinder (h=2*sz, r=hole, center=true, $fn=detail);
}
