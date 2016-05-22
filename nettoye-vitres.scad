$fn=80;

aimant_largeur = 11;
aimant_hauteur = 3;
aimant_largeur = 11;
aimant_hauteur_dome = 2;
aimant_rayon_dome =
aimant_hauteur_dome/2 + (aimant_largeur*aimant_largeur)/(8*aimant_hauteur_dome);

module maSphere() {translate([0,0,-80]) sphere(100);}
module monCube() {translate([0,0,60]) cube(120, center=true);}
module monCubeSup() {translate([0,0,70]) cube(120, center=true);}

module monDome() {
    difference() {
        intersection() {maSphere();monCube();};
        monCubeSup();
    }
}

module monAimant() {
    cube([aimant_largeur,15+59.1,aimant_hauteur]);
    translate([0,0,aimant_hauteur]) rotate([-90,0,0])
    linear_extrude(height=15+59.1) {
        polygon(points=[[0,0],
                        [aimant_largeur  , 0],
                        [aimant_largeur/2, -aimant_hauteur_dome]]);
    }
}

module mesAimants() { 
    for(i=[0:3]) {
        rotate([0,0,i*120]) translate([-aimant_largeur/2,0,3.3]) monAimant();
    }
}
module teteDeVisseuse() {
    rotate_extrude()
        polygon(points=[[   0,0],
                        [31/2,0],
                        [31/2,3.3],
                        [   0,8.5]]);
    cylinder(d=9,h=20);
}

module main() {
    difference() {
        monDome();
        mesAimants();
        teteDeVisseuse();
    }
}
//teteDeVisseuse();
main();
