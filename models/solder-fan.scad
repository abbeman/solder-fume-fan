fan_side = 140;
side = fan_side + 10;
// Hole margin, i.e. offset of screw hole from edge of fan.
hole_margin = (fan_side - 124.5) / 2;
filter_thickness = 10;
plate_thickness = 5;
filter_brace_thickness = 5;
filter_brace_width = 20;
fan_d = 135;
fan_thickness = 27;
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

module plate(height, thickness) {
  difference()
  {
    translate([0, -(side-height)/2, -thickness/2])
      cube([side, height, thickness], center = true);
      cylinder(h = 40, r = fan_d/2, center = true);
  }
}

// Separator between fan and filter.
translate([0, 0, -(plate_thickness)/2]) {
  cylinder(h = plate_thickness-1, r = 42/2, center = true);
  rotate([0, 0, 45]) {
    cube([3, fan_side, plate_thickness-1], center = true);
    cube([fan_side, 3, plate_thickness-1], center = true);
  }
}

// Fan holder.
hole_offset = fan_side/2 - hole_margin;
difference() {
  plate(side, plate_thickness + fan_thickness);
  // Remove screw holes.
  screw_hole(hole_offset, hole_offset);
  screw_hole(hole_offset, -hole_offset);
  screw_hole(-hole_offset, hole_offset);
  screw_hole(-hole_offset, -hole_offset);
  // Cavity for fan.
  translate([-(fan_side/2 - 8), -(fan_side/2 - 8), -(fan_thickness + plate_thickness + 20)])
    linear_extrude(height = fan_thickness + 20)
      minkowski() {
        square([fan_side - 8*2, fan_side - 8*2]);
        circle(r = 8);
      }
  // Hole for cable.
  translate([(fan_side - 18) / 2 - 28, fan_side/2, -(fan_thickness - 10)/2 - plate_thickness - 10/2])
    cube([18, 20, 10], center = true);
}




// Filter holder.
translate([0, 0, 12 + plate_thickness])
  difference() {
    union() {
      plate(side - 20, plate_thickness);
      translate([0, -20/2, -(12/2 + plate_thickness)])
        difference() {
          cube([side, side - 20, 13], center = true);
          translate([0, side - fan_side, 0])
            cube([fan_side, fan_side, 50], center = true);
        }
    }
    translate([hole_offset + 5, -(hole_offset + 5), 0])
      rotate([0, 0, 45])
        cube([150, 30, 50], center = true);
    translate([-(hole_offset + 5), -(hole_offset + 5), 0])
      rotate([0, 0, -45])
        cube([150, 30, 50], center = true);
  }
