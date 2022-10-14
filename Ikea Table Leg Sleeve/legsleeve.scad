$fn = 128;

thickness = 2;
height = 40;
topDiameter = 44.1;
bottomDiameter = 38;
compressionGapWidth = 3.5;
ringGap = 2;
fudge = 0.1;
tabWidth = 4;
tabDepth = 13;
wholeDiameter=6.3;




difference () {

    union(){
        cylinder(h=height+ringGap, r=(topDiameter/2)+thickness);
        translate([-(compressionGapWidth+2*tabWidth)/2,topDiameter/2,0])
            cube([compressionGapWidth+2*tabWidth, thickness+tabDepth, height+ringGap]);
    }

    translate([0,0,-fudge]) {
        cylinder(h=height+2*fudge+ringGap, r=(bottomDiameter/2));
        cylinder(h=height/2+2*fudge+ringGap, r=(topDiameter/2));
    }

    translate([-compressionGapWidth/2,0,0])
        cube([compressionGapWidth, (topDiameter/2)+thickness+tabDepth+fudge, height+ringGap]);

    translate([-(topDiameter+2*(thickness+fudge))/2,-(topDiameter/4),height/2])
        cube([topDiameter+2*(thickness+fudge), (3*topDiameter/4)+thickness+tabDepth+fudge, ringGap]);

    translate([-(2*(tabWidth+fudge)+compressionGapWidth)/2,(topDiameter+2*thickness+tabDepth)/2,height/4])
        rotate(a=[0,90,0])
            cylinder(h=2*(tabWidth+fudge)+compressionGapWidth, r=wholeDiameter/2);

    translate([-(2*(tabWidth+fudge)+compressionGapWidth)/2,(topDiameter+2*thickness+tabDepth)/2,3*height/4+compressionGapWidth/2])
        rotate(a=[0,90,0])
            cylinder(h=2*(tabWidth+fudge)+compressionGapWidth, r=wholeDiameter/2);



    distance=7;
    depth=10;
    logo_thickness=(thickness/2);
    difference() {
        translate([0,-topDiameter/2,height/2+(distance*tan(60)/2)+ringGap/2]) {
            rotate([0,90,90]) {
                union() {
                    translate([0,distance,0])
                        cylinder(h=depth,r=5, center=true);
                    translate([0,-distance,0])
                        cylinder(h=depth,r=5, center=true);
                    translate([distance*tan(60),0,0])
                        cylinder(h=depth,r=5, center=true);
                };
            };
        };
        difference() {
            cylinder(h=height+ringGap, r=(topDiameter/2)+thickness+depth);
            cylinder(h=height+ringGap, r=(topDiameter/2)+thickness);
        };
        cylinder(h=height+ringGap, r=(topDiameter/2)+thickness-logo_thickness);
    };

};


