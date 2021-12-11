fan_side = 140;
side = fan_side + 10;
hole_margin = (fan_side - 125) / 2;
filter_thickness = 10;
plate_thickness = 5;
filter_brace_thickness = 5;
filter_brace_width = 20;
fan_d = 135;
module screw_hole (x, y) {
  translate([x, y, 0])
    cylinder(h = 40, r = 2.2, center = true);
}

module filter_brace(width, thickness) {
    cube([width, thickness, 115], center = true);
}

module filter_brace_side(width, thickness) {
 rotate([0, 0, 90])
    filter_brace(width, thickness);}

module plate(height) {
  difference()
  {
    translate([0, -(side-height)/2, -plate_thickness/2])
      cube([side, height, plate_thickness], center = true);
      cylinder(h = 40, r = fan_d/2, center = true);
  }
}

hole_offset = (fan_side - hole_margin)/2;
difference() {
  plate(side);
  screw_hole(hole_offset, hole_offset);
  screw_hole(hole_offset, -hole_offset);
  screw_hole(-hole_offset, hole_offset);
  screw_hole(-hole_offset, -hole_offset);
}

translate([0, 0, 12 + plate_thickness/2])
  difference() {
    plate(side - 20);
    translate([hole_offset + 5, -(hole_offset + 5), 0])
      rotate([0, 0, 45])
        cube([150, 30, plate_thickness*2+1], center = true);
    translate([-(hole_offset + 5), -(hole_offset + 5), 0])
      rotate([0, 0, -45])
        cube([150, 30, plate_thickness*2+1], center = true);
  }
