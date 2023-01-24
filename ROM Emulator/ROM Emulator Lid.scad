use <CapturedShaft.scad>

// OpenSCAD parameters
$fn=100;
fudge = 0.01;

// Basic Lid Dimensions
width            =  98.00;
length           = 126.00;

// M2x6x3.5 Embedded Nut
finsertdiameter =    3.41;
finsertdepth    =    6.00;

// M2x12 Hex Socket Cap Bolt
fheaddiameter  =     4.00;
fheaddepth     =     2.00;
fshankdiameter =     2.00;
fshankdepth    =    12.00;

// Guard adjustments and derived dimensions
if (fshankdepth < finsertdepth) {
    fshankdepth = finsertdepth;
}
fsize = finsertdiameter * 1.5;
thickness = 2 * fheaddepth;

union() {

difference() {

    // Lid
    cube([width, length, thickness]);
    
       

    // Fastener holes
    translate([fsize/2, fsize/2, -fudge]) {
        inserthole();
    }
    translate([width-fsize/2, length-fsize/2, -fudge]) {
        inserthole();
    }
    translate([fsize/2, length-fsize/2, -fudge]) {
        inserthole();
    }
    translate([width-fsize/2, fsize/2, -fudge]) {
        inserthole();
    }
    
    
    //Alignment Inspection Windows
    //translate([(width-width*0.8)/2, 50, -fudge]) {
    //    cube([80, 65, thickness+2*fudge]);
    //}
    //translate([55,10,-fudge]) {
    //    cube([8,60,thickness+2*fudge]);
    //}
    //translate([10,10,-fudge]) {
    //    cube([35,60,thickness+2*fudge]);
    //}

    // Power LED
    translate([50, 29, thickness]) {
        cylinder(h=13+thickness, r=2.3, center=true);
    }
    // Run LED
    translate([50, 36, thickness]) {
        cylinder(h=13+thickness, r=2.3, center=true);
    }
    
    // Holes for switches    
        // Load Switch
    translate([50, 44, -thickness-fudge]) {
        cylinder(h=10, r=2+6*.3+1); //r=2+6*.3+1);
    }
    // Reset Switch
    translate([68, 34, -thickness-fudge]) {
        cylinder(h=10, r=2+6*.3+1); //r=2+6*.3+1);
    }

}

// Hold downs
translate([thickness-1,27,-21]) {
    cube([2,60,21]);
}
translate([width-thickness,27,-21]) {
    cube([2,60,21]);
}


        // Load Switch
    translate([50, 44, thickness+fudge]) {
        rotate([0,180,0]) {
            capturedButton(.3, 2.9, 22, 3, 2);
        }
    }
    // Reset Switch
    translate([68, 34, thickness+fudge]) {
        rotate([0,180,0]) {
            capturedButton(.3, 2.9, 12, 3, 2);
        }
    }

}


module inserthole() {
    union() {
        translate([0,0,thickness-fheaddepth+fudge]) {
            cylinder(h=fheaddepth+2*fudge,r=fheaddiameter/2);
        }
        cylinder(h=thickness+2*fudge,r=fshankdiameter/2);
    }    
}