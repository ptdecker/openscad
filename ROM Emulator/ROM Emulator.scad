// OpenSCAD parameters
$fn   = 50.00;
fudge =  0.01; // used to fix render problems

// Basic box dimensions
width           =  98.00;
length          = 126.00;
height          =  30.00;
thickness       =   2.00;

// M2x6x3.5 Embedded Nut
finsertdiameter =   3.41;
finsertdepth    =   6.00;

// M2x12 Hex Socket Cap Bolt
fheaddiameter   =   4.00;
fheaddepth      =   2.00;
fshankdiameter  =   2.00;
fshankdepth     =  12.00;

// Ribbon cable slot dimensions
slotwidth       =  39.00;
slotdepth       =   1.50;
slotposition    =  28.00;

// USB port dimensions
portwidth       = 11.00;
portdepth       =  9.00;
portposition    = 63.50;  // horizontal position
portoffset      =  3.00;  // vertical position from top

// Guard adjustments and derived dimensions
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
        
        // bottom retainer
        translate([0, thickness, thickness]) {
            cube([width, 15.5, 6.5]);
        }

    }

    // fastener holes
    translate([fsize/2, fsize/2, height-fshankdepth+fudge]) {
        inserthole();
    }
    translate([width-fsize/2, length-fsize/2, height-fshankdepth+fudge]) {
        inserthole();
    }
    translate([fsize/2, length-fsize/2, height-fshankdepth+fudge]) {
        inserthole();
    }
    translate([width-fsize/2, fsize/2, height-fshankdepth+fudge]) {
        inserthole();
    }

    // ribbon cable slot
    translate([slotposition, -fudge, height-slotdepth]) {
        cube([slotwidth,thickness+2*fudge,slotdepth+.1]);
    }

    // USB port
    translate([width-portposition-portwidth, length-thickness-fudge, height-portdepth-portoffset]) {
        cube([portwidth,thickness+2*fudge,portdepth+fudge]);
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