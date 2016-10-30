$fn=50;


// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;


///////////////////////////////////////////////////////
// Constants
m3_screw_slop = 0.1;
m3_screw_dia = 3.0 + m3_screw_slop;
m3_screw_head_slop = 0.45;
m3_screw_head_dia = 5.5 + m3_screw_head_slop;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;


///////////////////////////////////////////////////////
// Ajustable variables

// 30 reel - 1.5 pour pression
wheels_spacing = 30 - 1.5;
wheels_height_pos = 37;


belt_position = 21;
belt_spacing  = 9.5;
extrusion_width = 15;

ball_joints_spacing = 40;
ball_joints_z_position = 25;
horn_thickness=15;
horn_height = 18;
horn_length = 12;

surface_height = 6;



module 623_wheel() {
    rotate([0,90,0]) translate([0,0,-(2+2.25+2.5+2.25+2)/2]) {
                                         cylinder(h=2.00, d=11);
        translate([0,0,2])               cylinder(h=2.25, d1=11, d2=15.5);
        translate([0,0,2+2.25])          cylinder(h=2.50, d=15.5);
        translate([0,0,2+2.25+2.5])      cylinder(h=2.25, d2=11, d1=15.5);
        translate([0,0,2+2.25+2.5+2.25]) cylinder(h=2.00, d=11);
    }
}
module wheel_hole(the_height) {
    rotate([0,90,0]) {
        translate([0,0,-the_height])
            cylinder(d=m3_screw_dia, h=the_height);
        cylinder(d=m3_screw_head_dia, h=20);
    }
}

belt_gt2_height = 10;
module belt_gt2_part() {
    for(m=[0,1]) mirror([0,m,0]) {
        translate([-0.75,0.56,0])
            difference() {
                cube([0.19, 0.19, belt_gt2_height]);
                translate([0.19,0.19,0])cylinder(r=0.19, h=belt_gt2_height);
            }
    }
    translate([-0.75,-0.56,0])cube([0.19, 2*0.56, belt_gt2_height]);
    translate([0.19-0.75, 0, 0])cylinder(r=0.56, h=belt_gt2_height);
}

module belt_gt2(number) {
    mirror([0,0,1]) rotate([0, 90, 0]) rotate([0, 0, -90]) {
        translate([-1.38,-1,0]) cube([1.38-0.75, number*2, belt_gt2_height]);
        for(i = [0:number-1]) translate([0,2*i,0]){
            belt_gt2_part();
        }
    }
}

module around_the_carriage() {
    the_height = 100;
    // The extrusion
    translate([-extrusion_width/2, 0, 0])
        %cube([extrusion_width, extrusion_width, the_height], center=true);
    
    // The belt
    for(m=[0,1]) {
        mirror([0,m,0])
        translate([belt_position, belt_spacing/2, 0]) {
            //%cube([6, 2, the_height]);
            #belt_gt2(10);
        }
    }
    
    // The wheels
    translate([0, -wheels_spacing/2, 0]) {
        translate([-extrusion_width/2, 0]) #%623_wheel();
        translate([3,0,0]) wheel_hole(20);
    }
    translate([0, +wheels_spacing/2, -wheels_height_pos/2]) {
        translate([-extrusion_width/2, 0]) #%623_wheel();
        translate([3,0,0]) wheel_hole(20);
    }
    translate([0, +wheels_spacing/2, +wheels_height_pos/2]) {
        translate([-extrusion_width/2, 0]) #%623_wheel();
        translate([3,0,0]) wheel_hole(20);
    }
    
    // Hole for the ball joints
    translate([horn_thickness/2, 0, ball_joints_z_position])
        rotate([90,0,0]) cylinder(r=m3_wide_radius, h=60, center=true);

}


module carriage() {
    // "Surface"
    pos = ball_joints_spacing/2-horn_length;
    translate([0, -pos, ball_joints_z_position-horn_height/2])
        cube([horn_thickness/2, 2*pos, horn_height]);
    translate([0, -pos, -15])
        cube([surface_height, 28, 42]);
    
    difference() {
        union() {
            translate([0, -ball_joints_spacing/2, -15])
                cube([surface_height, ball_joints_spacing, 15]);
            translate([0, -wheels_spacing/2-.25, 0])
                rotate([0,90,0]) cylinder(h=surface_height, d=11);

            translate([0, 0, -15]) intersection() {
                    translate([0, -ball_joints_spacing/2, -ball_joints_spacing/2])
                        cube([surface_height, ball_joints_spacing, ball_joints_spacing/2]);
                    rotate([0,90,0]) cylinder(d=ball_joints_spacing, h=surface_height);
                }
        }

        cutout_width = 18;
        union() {
            translate([0, -cutout_width/2, -15])
                cube([surface_height, cutout_width, 20]);
            translate([0,0,-15])
                rotate([0,90,0])scale([cutout_width*4/3, cutout_width, 1])
                    cylinder(h=surface_height, d=1);
       }
    }
    
    // Belt clamps
    belt_clamp_height=15;
    translate([0,0,0])
        cube([30,5, belt_clamp_height]);
    translate([0,4.75+1.45,0])
        cube([30,4.75, belt_clamp_height]);
    translate([0,0,0])
        cube([30,4.75, belt_clamp_height]);
    


    // Ball joint mount horns.
    translate([0,0,ball_joints_z_position])
        intersection() {
            translate([0, -ball_joints_spacing/2, -horn_height/2])
                cube([horn_thickness, ball_joints_spacing, horn_height]);
          for (x = [0, 1]) {
              mirror([0, x, 0]) translate([horn_thickness/2, 40/2, 0])
                rotate([90, 0, 0])
                    cylinder(r2=14, r1=3, h=horn_length);
          }
            
        }
}

difference() {
    carriage();
    around_the_carriage();
}
//around_the_carriage();

//translate([0,0,6.5])rotate([-90,0,0])rotate([0,90,0]) import("/home/felix/tmp/old_carriage.stl", convexity=3);
