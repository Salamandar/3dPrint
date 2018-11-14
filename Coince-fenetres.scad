$fn=50;
largeur=45;
longueur=150;

epaisseur_plaque = 2;
epaisseur_attache= 5;


module plaque() {
    difference() {
        square([longueur, largeur]);
        trou1();
        trou2();
    }
}
module trou1() {
    translate([23,0]) difference() {
        square([30,15]);
        translate([11.5,0]) square([11,15]);
    }
}
module trou2() {
    translate([126,0])
        square([7.8,25]);
}


module attaches() {
difference() {
    minkowski(){
        trou1();
        circle();
    }
    trou1();
}
difference() {
    minkowski(){
        trou2();
        circle();
    }
    trou2();
}
}

intersection() {
    union() {
        linear_extrude(height=epaisseur_attache)
            attaches();
        linear_extrude(height=epaisseur_plaque)
            minkowski() {
                hull() attaches();
                circle(d=10);
            }
    }
    linear_extrude(height=epaisseur_attache)
        plaque();
}