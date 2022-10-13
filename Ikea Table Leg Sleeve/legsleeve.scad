$fn = 128;

thickness = 2;
height = 40;
topDiameter = 45;
bottomDiameter = 39;
compressionGapWidth = 2;
ringGap = 2;
fudge = 0.1;

union() {
    difference () {
        cylinder(h=height, r=(topDiameter/2)+thickness);
        cylinder(h=height, r=(bottomDiameter/2));
        cylinder(h=height/2, r=(topDiameter/2));
        translate([-compressionGapWidth/2,0,0])
            cube([compressionGapWidth, (topDiameter/2)+thickness+fudge, height]);
        translate([-(topDiameter+2*(thickness+fudge))/2,-(topDiameter/4),height/2])
            cube([topDiameter+2*(thickness+fudge), (3*topDiameter/4)+thickness+fudge, ringGap]);
    };
}
