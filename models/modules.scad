module plate(height, thickness, hole_d) {
  difference() {
    translate([0, 0, -thickness/2]) {
      cube([height, height, thickness], center = true);
    }
    cylinder(h = height+1, r = hole_d/2, center = true);
  }
}

module screw_hole (x, y, screw_d, depth, countersink) {
  translate([x, y, -depth]) {
    cylinder(h = depth + 1, r = screw_d/2 + 0.2);
    if (countersink > 0) {
      translate([0, 0, depth - countersink]) {
        // Six sided counter sink.
        cylinder(h = countersink + 1, r = 7.8/2 + 0.2, $fn=6);
      }
    }
  }
}

