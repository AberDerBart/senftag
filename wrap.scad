
function deg_to_rad(a) = a * PI / 180;
function rad_to_deg(a) = a * 180 / PI;

module wrap_cylinder(r, h, depth, center=false, range=[0, 360]) {
  $effective_fa = ($fn != 0) ? 360/$fn : $fa;

  $step = deg_to_rad($effective_fa);
  $r = r * cos($effective_fa / 2);
  $r_i = (r-depth) * cos($effective_fa / 2);

  module strip(a) {
    translate([-(a + $step/2) * $r,0,0]) intersection(){
      children();
      translate([a * $r -0.01, center ? -h/2 : 0,0]) square([$step * $r + 0.02, h]);
    }
  }
  
  for($a=[deg_to_rad(range[0]) : $step : deg_to_rad(range[1]) - $step]) {
    rotate([90, 0, 90 + rad_to_deg($a + $step/2)])
      translate([0,0,$r])
      mirror([0,0,1])
      linear_extrude(depth, scale=[$r_i / $r, 1])
      strip($a)
      children();
  }
}
