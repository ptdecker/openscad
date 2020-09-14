$fn=50;

width = 67;
length = 100;
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


thickness = 2 * fheaddepth;


difference() {

   // base
   cube([width, length, thickness]);



    translate([fsize/2, fsize/2, 0]) {
        inserthole();
    }
    translate([width-fsize/2, length-fsize/2, 0]) {
        inserthole();
    }
    translate([fsize/2, length-fsize/2, 0]) {
        inserthole();
    }
    translate([width-fsize/2, fsize/2, 0]) {
        inserthole();
    }

}

module inserthole() {
    union() {
        translate([0,0,thickness-fheaddepth]) {
            cylinder(h=fheaddepth,r=fheaddiameter/2);
        }
        cylinder(h=thickness,r=fshankdiameter/2);
    }    
}