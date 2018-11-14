$fn=100;

m3_din=3.2;

module BoltM3() {
    cylinder(d=m3_din,   h=20);
    cylinder(d=6, h=3.2);
    translate([0,0,3.2])
    cylinder(d=6,   h=2.3, $fn=6);
}

module KosselFrame() {
    translate([-24, -50, 0]) cube([20, 100, 45]);
    translate([ -4, -50, 0]) cube([ 4,  55, 45]);
    
    
    for (i=[7.5, 37.5])
        translate([-27, 0, i])
        rotate([0, 90, 0]) {
            cylinder(d=3,   h=50);
            cylinder(d=5.5, h=3);
        }
}

// hauteur relative au bord de la frame
hauteur = 6;

module SingleLeveler() {
    difference() {
        translate([0,-5,2]) {
            cube([6, 15, 43+hauteur]);
            
            hull() {
                translate([0, 10,  0]) cube([ 6, 5, 5]);
                translate([0, 15, 43+hauteur]) cube([20, 5, 6]);
            }
            translate([0, 0, 43+hauteur]) cube([20, 20, 6]);
            translate([15,5, 49+hauteur]) cylinder(d=8,h=1);
        }
        #KosselFrame();
        
        translate([15, 0, 43+hauteur])
        #BoltM3();
    }
}


module DoubleLeveler_old() {
    distance=80;
    
    difference() {
        union() {
            for (i=[0, 1]) rotate([0,0,-60*i])  mirror([i,0,0]) translate([0,distance,0])
            translate([0,-5,2]) {
                cube([6, 15, 43+hauteur]);
                
                hull() {
                    translate([0, 10,  0]) cube([ 6, 5, 5]);
                    translate([0, 15, 43+hauteur]) cube([20, 5, 6]);
                }
                translate([0, 0, 43+hauteur]) cube([sin(30)*distance+15-0.15, 20, 6]);
            }
        }
        union() {
            for (i=[0, 1]) rotate([0,0,-60*i])  mirror([i,0,0]) translate([0,distance,0])
            %KosselFrame(); 
            rotate([0,0,-30]) translate([0, 98, 42+hauteur]) 
            BoltM3();
        }

    }
    
    
}
module DoubleLeveler() {
    distance=70;
    
    difference() {
        union() {
            for (i=[0]) rotate([0,0,-60*i])  mirror([i,0,0]) translate([0,distance,0])
            translate([0,-5,2]) {
                cube([6, 15, 43+hauteur]);
                
                hull() {
                    translate([0, 10,  0]) cube([ 6, 5, 5]);
                    translate([0, 15, 43+hauteur]) cube([20, 5, 6]);
                }
                translate([0, 0, 43+hauteur]) cube([sin(30)*(distance+28.2), 20, 6]);
            }
        }
        union() {
            for (i=[0, 1]) rotate([0,0,-60*i])  mirror([i,0,0]) translate([0,distance,0])
            #KosselFrame(); 
            rotate([0,0,-30]) translate([0, 83, 42+hauteur]) 
            #BoltM3();
        }

    }
    
    
}






//%DoubleLeveler_old();
DoubleLeveler();


SingleLeveler();


