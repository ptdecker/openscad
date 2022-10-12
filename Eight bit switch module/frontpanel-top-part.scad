$fn=50;

buffer = 15;
maxWidth = 13;
numDataSwitches = 8;
controlLabels = ["BUS", "LOAD"];
numBlank = 1;
width = (12.75 * maxWidth) + (2 * buffer);
height = 8 + (2 * buffer);
thickness = 4;
spacing = 13;
ridge = 3;
switchWidth = (spacing * maxWidth);
switchBuffer = (width - switchWidth + buffer) / 2;
numControlSwitches = len(controlLabels);
fontFace = "osifont:style=Medium";

// M2x12 Hex Socket Cap Bolt
fheaddiameter = 4;
fheaddepth = 2;
fshankdiameter = 2;
fshankdepth = 20;

fsize = fheaddiameter * 2;


fthickness = 2 * fheaddepth;


difference() {
    cube([width, height, 2*thickness]);
    for (i = [0:1:(numDataSwitches + numBlank + numControlSwitches - 1)]) {
        if ((i < numDataSwitches) || (i >= (numDataSwitches + numBlank))) {
            // LED holes
            translate([ (i * spacing) + switchBuffer, (height / 2) + 7, thickness-0.1])
                cylinder(h=thickness + 0.2, r=1.6); // last was 2 and too big
            // LED Countersink
            translate([ (i * spacing) + switchBuffer, (height / 2) + 7, thickness+(thickness / 2)])
                cylinder(h=thickness + 0.2, r1=1.6, r2=4); // last was 3.5 made bigger for more flare
            // Switch holes
            translate([ (i * spacing) + switchBuffer, (height / 2) - 3, thickness-0.1])
                cylinder(h=thickness + 0.2, r=3.25); // last was 3.5 & slightly too big
            // Switch retainer
            translate([ (i * spacing) + switchBuffer, (height / 2) - 10, thickness+.4])
                cube([1,4,1], center = true); 
        }
        // Switch labels
        if (i < numDataSwitches) {
            translate([ (i * spacing) + switchBuffer, (height / 2) - 13, thickness+3])
                linear_extrude(1.5)
                text(str(2^(numDataSwitches - i - 1)), 5, halign="center", valign="center", font=fontFace);
        }
        // Control labels
        if (i >= (numDataSwitches + numBlank)) {
            translate([ (i * spacing) + switchBuffer, (height / 2) - 13, thickness+3])
                linear_extrude(1.5)
                text(controlLabels[i - numDataSwitches - numBlank], 3, halign="center", valign="center", font=fontFace);
        }
    }

    translate([4+ridge, height - 5.5, thickness+3])
        linear_extrude(1.5)
        text("SWITCHED INPUT REGISTER", 3, font=fontFace);

    // Inset
    translate([2.5*ridge,ridge, -0.1])
        cube([width - 5 * ridge, height - 2 * ridge, thickness+0.1]);

    // Mounting holes
    translate([fsize/2, fsize/2, 0.1]) {
        inserthole();
    }
    translate([width-fsize/2, height-fsize/2, 0.1]) {
        inserthole();
    }
    translate([fsize/2, height-fsize/2, 0.1]) {
        inserthole();
    }
    translate([width-fsize/2, fsize/2, 0.1]) {
        inserthole();
    }


}

module inserthole() {
    union() {
        translate([0,0,2*thickness-fheaddepth]) {
            cylinder(h=fheaddepth,r=fheaddiameter/2);
        }
        translate([0,0,-1])
            cylinder(h=2*thickness+1,r=fshankdiameter/2);
    }    
}