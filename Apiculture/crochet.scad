$fn=50;
diam_vis = 4;

plaque_epaisseur = 2;
plaque_largeur = 15;


difference_vis = 25;

vis_bas_y = plaque_largeur/2;


difference() {
    cube([plaque_largeur,40, plaque_epaisseur]);
    translate([plaque_largeur / 2, vis_bas_y])
        cylinder(h = plaque_epaisseur, d=diam_vis + 0.5);
    
    translate([plaque_largeur / 2, vis_bas_y + difference_vis]) {
        translate([0,diam_vis/2]) cylinder(h = plaque_epaisseur, d=diam_vis + 0.5);
        cube([plaque_largeur /2, diam_vis, plaque_epaisseur]);
    }
    
}