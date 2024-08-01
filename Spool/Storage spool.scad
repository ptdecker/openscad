$fn=120;
fudge=.1;


transverse = 10; // distance between flanges
core = 10;       // core diameter
arbor = 8;        // arbor diameter (less than core)
flange = 30;     // flange diameter
thickness = 1;   // flange thickness
fit_tollerance = 0.5; // inner and outer hub fit tollerance

module Hub(h, od, id, t) {
    difference() {
        cylinder(h,r=od,true);
        translate([0,0,-fudge]) {
            cylinder(h+(2*fudge),r=id,true);
        };
    };
};

module Disk(d1, d2, t) {
    difference() {
        cylinder(t,r=d1,true);
        translate([0,0,-fudge]) {
            cylinder(t+(2*fudge),r=d2,true);
        };
    };
};



// Inner Hub

translate([-(flange+10),0,0]) {
    union() {
        Disk(flange, core-thickness, thickness);
        Hub(transverse+(2*thickness), core-thickness-fit_tollerance, arbor);
    };
};


// Outer Hub
translate([(flange+10),0,0]) {
    union() {
        Disk(flange, core-thickness, thickness);
        Hub(transverse+(2*thickness), core, core-thickness);
    };
};