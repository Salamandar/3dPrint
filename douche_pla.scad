$fn=100;


module barre() {
    translate([0,0,-3.5])cylinder(d=21,h=3.5);
    #difference() {
        cylinder(d=21,h=4);
        translate([-20,-8.6,-0.1]) cube([40,20,4.2]);
    }
    translate([0,0,-0.1])    cylinder(d=5,h=2);
    translate([0,0, 1.5])    cylinder(d=9,h=50);
    translate([0,0,1.5+6.5]) cylinder(d=14,h=50);
}
module support_barre() {
    difference() {
    union (){cylinder(d=15, h=8); translate([0,-15/2])cube([40,15,8]);}
    #barre();
    }
}

module pomme() {
    translate([  0,-10,0])rotate([-90,0,0]) cylinder(d1=21, d2=24,h=55);
    translate([0,0,10])cube([22,100,20], center=true);
}
module support_pomme() {
    translate([0,-1.5,18]) rotate([-90])cylinder(d=30,h=40);

translate([2.5,0,3]) cube([10,38.5,15]);
translate([9.5,0,3])rotate([-90,0,0])cylinder(d=6,h=38.5);
translate([-6,0,0]) cube([15.5,38.5,13]);
translate([-5.9,0,3])rotate([-90,0,0])cylinder(d=6,h=38.5);
translate([-8.9,0,2.5])rotate([0,-14.5,0])#cube([5,38.5,12.8]);
}

module main() {
    difference() {
    union() {
        support_barre();
        translate([35,15,0]) rotate([0,0,180+45]) support_pomme();
    }
    #translate([35,15,18]) rotate([0,0,180+45])pomme();
    }
}

main();

//linear_extrude(100,scale=2) scale([1,0.7]) circle(10);