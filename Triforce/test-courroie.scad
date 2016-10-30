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


belt_position = 2.5;
belt_spacing  = 9.5;
extrusion_width = 15;

ball_joints_spacing = 40;
ball_joints_z_position = 25;
horn_thickness=15;
horn_height = 18;
horn_length = 12;

surface_height = 6;


belt_gt2_height = 6;
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

    // The belt
    mirror([0,1,0]) translate([belt_position, belt_spacing/2,-8])   belt_gt2(9);
    mirror([0,0,0]) translate([belt_position, belt_spacing/2, 4])   belt_gt2(3);
    mirror([0,0,0]) translate([belt_position, belt_spacing/2,-8])   belt_gt2(3);
    
}


module carriage() {
    // "Surface"
    pos = ball_joints_spacing/2-horn_length;
    translate([0, 0, -20/2])
        cube([2.5, 13, 20]);


    // Belt clamps
    belt_clamp_height=belt_position + belt_gt2_height;
    translate([0,0,-15/2])
        cube([belt_clamp_height,5.5, 15]);

    translate([0,4.75+1.8+5/2,0]) {
         for(m=[0,1]) mirror([0,0,m]) translate([0,0,5/2+1.8]){
            rotate([0,90,0]) cylinder(d=5,h=belt_clamp_height);
            translate([0,-5/2,0]) cube([belt_clamp_height,5/2,5/2]);
            translate([0,0,-5/2]) cube([belt_clamp_height,5/2,5/2]);
        }
    }
    difference([]) {
        translate([0,5,-6/2]) cube([belt_clamp_height,5/2,6]);
        diam = 5+2.6;
        translate([-0.05,4.75+1.45+5/2, 5/2+1.4]) rotate([0,90,0]) cylinder(d=diam,h=belt_clamp_height+.1);
        translate([-0.05,4.75+1.45+5/2,-5/2-1.4]) rotate([0,90,0]) cylinder(d=diam,h=belt_clamp_height+.1);
        
    }
//    translate([0,5+1.45,0])
//        cube([30,4.75, belt_clamp_height]);
    
    
    

}

rotate([0,-90,0])
difference() {
    carriage();
    #around_the_carriage();
}
