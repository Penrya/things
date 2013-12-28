// Numbers you need to change to adapt to your cutting boards
grooves = 3;
board_thickness = 25.4/3 + 0.1; // add slack
holder_width = 20;

// Numbers that change the style
total_height_factor = 1.5*.5;
groove_height_proportion = 0.75;

/*
// Numbers you need to change to adapt to your cutting boards
grooves = 3;
board_thickness = 25.4/3 + 0.1 + 0.04; // add slack + observed error
holder_width = 140;

// Numbers that change the style
total_height_factor = 1.5;
groove_height_proportion = 0.75;
*/
// End of configuration

eps = 0.1; // epsilon (any small number)

scale([board_thickness,
       holder_width,
       board_thickness * total_height_factor]) {
  difference() {
    cube(size=[1 + 2*grooves, 1, 1]);
    for (i = [0 : grooves-1]) {
      translate([1 + 2*i, -eps, 1 - groove_height_proportion])
        cube(size=[1, 1+2*eps, 1]);
    }
  }
}
