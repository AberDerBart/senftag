include <BOSL/transforms.scad>
include <wrap.scad>

// Label (your name)
label="BART";

// Font (copy a font from Help->Font List)
font="Roboto:style=Medium";

// Label depth (in mm)
label_depth=1.;//[0:.1:3]

total_angle=250;//[0:1:360]


// The inner diameter of the tag, determined by your glass
inner_diameter=52;

// The outer diameter of the tag
outer_diameter=64;

profile_radius=8;

// maximum angle in circle
$fa=5;//[0.1:.1:120]


 /* [Debug] */
show_text_angle=false;

// The angle the text spans (this should cover your text, lower improves performance)
text_angle=360; //[0:1:360]

$fs=.1;

// TODO: height, font height, diameter

module profile(){
  intersection(){
    $profile_width = (outer_diameter-inner_diameter)/2;
    xmove(-profile_radius)circle(r=profile_radius);
    xmove(-$profile_width)ymove(-7.5)square([$profile_width,15]);
  }
}

if(show_text_angle && $preview){
  #zrot(-text_angle/2)rotate_extrude(angle=text_angle)rotate([1,0,0],-90)move([outer_diameter/2-1,-10,0])square([2,20]);
}

difference(){
  zrot(180-total_angle/2)rotate_extrude(convexity = 10, angle=total_angle) translate([-inner_diameter/2, 0, 0]) profile();
  wrap_cylinder(r=outer_diameter/2+1, h=15, depth=label_depth+1, center=true, range=[-total_angle/2,total_angle/2])
    text(halign="center", font=font, valign="center", label);
}


