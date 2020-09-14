$fn=50;

width = 67;
length = 100;
height = 25;
thickness = 2;
phi = 1.6180339887;
//length = round(phi * width);
//height = round(width / phi);

// M2x6x3.5 Embedded Nut
finsertdiameter = 3.41;
finsertdepth = 6;

// M2x12 Hex Socket Cap Bolt
fheaddiameter = 4;
fheaddepth = 2;
fshankdiameter = 2;
fshankdepth = 12;

if (fshankdepth < finsertdepth) {
    fshankdepth = finsertdepth;
}

fsize = finsertdiameter * 1.5;


difference() {

    union() {
        // base
        cube([width, length, thickness]);

        // sides
        cube([width, thickness, height]);
        cube([thickness, length, height]);
        translate([0, length - thickness, 0]) {
            cube([width, thickness, height]);
        }
        translate([width - thickness, 0, 0]) {
            cube([thickness, length, height]);
        }

        // posts
        translate([fsize/2, fsize/2, 0]) {
            cylinder(r=fsize/2, h=height);
        }
        translate([width-fsize/2, length-fsize/2, 0]) {
            cylinder(r=fsize/2, h=height);
        }
        translate([fsize/2, length-fsize/2, 0]) {
            cylinder(r=fsize/2, h=height);
        }
        translate([width-fsize/2, fsize/2, 0]) {
            cylinder(r=fsize/2, h=height);
        }
    }


    translate([fsize/2, fsize/2, height-fshankdepth]) {
        inserthole();
    }
    translate([width-fsize/2, length-fsize/2, height-fshankdepth]) {
        inserthole();
    }
    translate([fsize/2, length-fsize/2, height-fshankdepth]) {
        inserthole();
    }
    translate([width-fsize/2, fsize/2, height-fshankdepth]) {
        inserthole();
    }

}

module inserthole() {
    union() {
        translate([0,0,fshankdepth-finsertdepth]) {
            cylinder(h=finsertdepth,r=finsertdiameter/2);
        }
        cylinder(h=fshankdepth,r=fshankdiameter/2);
    }    
}