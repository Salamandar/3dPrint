$fn=100;
module usb() {
	translate([6,0,2.25]) rotate([90,0,0])
	linear_extrude(height = 11.75) {
		difference() {
			minkowski() {
				square([11.9, 4.4], center=true);
				circle(d = 0.1);
			}
			square([11.4,4.1], center=true);
		}	
	}
}
usb();
cube([12,20,4.5]);