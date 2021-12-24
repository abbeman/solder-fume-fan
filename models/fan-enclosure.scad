$fa = 0.01;
$fs = 0.1;
include <modules.scad>

fan_side = 140;
screw_hole_spacing = 124.5;
fan_thickness = 27;

fan_enclosure(fan_side, fan_thickness, screw_hole_spacing);

module fan_enclosure(fan_side, fan_thickness, screw_hole_spacing) {
  hole_d = fan_side - 5;
  // Add a bit of margin around the fan itself.
  fan_side = fan_side + 2;
  side = fan_side + 10;
  plate_thickness = 7;
  hole_margin = (fan_side - screw_hole_spacing) / 2;
  hole_offset = fan_side/2 - hole_margin;
  rotate([180, 0, 0])
    union() {
      // Separator between fan and filter.
      translate([0, 0, -(plate_thickness-1)/2]) {
        cylinder(h = plate_thickness-1, r = (fan_side  * 0.3)/2, center = true);
        rotate([0, 0, 45]) {
          cube([3, fan_side, plate_thickness-1], center = true);
          cube([fan_side, 3, plate_thickness-1], center = true);
        }
      }
    
      difference() {
        plate(side, plate_thickness + fan_thickness, hole_d);
        // Remove screw holes.
        screw_hole( hole_offset,  hole_offset, 4, 40, 0);
        screw_hole( hole_offset, -hole_offset, 4, 40, 0);
        screw_hole(-hole_offset,  hole_offset, 4, 40, 0);
        screw_hole(-hole_offset, -hole_offset, 4, 40, 0);
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
    }
}
