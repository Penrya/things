// Numbers you need to change to adapt to your cutting boards
widths = [8.57 + .15, 8.57 + .15, 8.57 + .23];
offset = 7.5;
period = 16;
holder_width = 120;
total_height = 25;

// Numbers that change the style
bottom_height_proportion = 0.2;

// End of configuration

eps = 0.1; // epsilon (any small number)

scale([1, holder_width, total_height]) {
  difference() {
    cube(size=[offset + len(widths)*period, 1, 1]);
    for (i = [0 : len(widths)-1]) {

      translate([offset + i*period, -eps, bottom_height_proportion])
        cube(size=[widths[i], 1+2*eps, 1]);
    }
  }
}
