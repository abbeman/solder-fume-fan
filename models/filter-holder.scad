$fa = 0.01;
$fs = 0.1;
include <modules.scad>

fan_side = 140;
screw_hole_spacing = 124.5;

filter_thickness = 10;
plate_thickness = 7;

rotate([90, 0, 0]) {
  filter_holder(fan_side, filter_thickness, plate_thickness, screw_hole_spacing);
}

module filter_holder(fan_side, filter_thickness, plate_thickness, screw_hole_spacing) {
  hole_d = fan_side - 5;
  // Add some space around the fan.
  fan_side = fan_side + 2;
  // Outer side of the filter holder.
  side = fan_side + 10;
  hole_margin = (fan_side - screw_hole_spacing) / 2;
  // Hole position, or x/y distance of the screw holes from the center of the
  // model.
  hole_pos = fan_side/2 - hole_margin;
  // Add some room for the filter.
  filter_thickness = filter_thickness + 2;
  translate([0, -(plate_thickness + filter_thickness), 0]) {
    rotate([90, 0, 0]) {
      difference() {
        union() {
          plate(side, plate_thickness, hole_d);
          translate([0, 0, -(filter_thickness/2 + plate_thickness)])
            difference() {
              cube([side, side, filter_thickness + 1], center = true);
              // Remove space for the filter.
              translate([0, side - fan_side, 0])
                cube([fan_side, side + (side - fan_side), filter_thickness + 2], center = true);
            }
        }
        // Remove screw holes.
        screw_hole( hole_pos,  hole_pos, 4, 40, 3);
        screw_hole( hole_pos, -hole_pos, 4, 40, 3);
        screw_hole(-hole_pos,  hole_pos, 4, 40, 3);
        screw_hole(-hole_pos, -hole_pos, 4, 40, 3);
      }
    }
  }
}
