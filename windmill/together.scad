use <base.scad>;
use <generator.scad>;
use <wings.scad>;

wing_angle = atan2(.10*5/2, 2);
echo(wing_angle);

base();
translate([5/2 - .1*5/2/2,0,15 + 2/2]) rotate([0,90-wing_angle,0]) wings();
translate([0,0,15]) generator();