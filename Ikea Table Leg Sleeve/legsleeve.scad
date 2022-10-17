// Ikea Adjustable Leg Table Compression Sleeve
//
// GitHub Repo:  https://github.com/ptdecker/openscad/tree/master/Ikea%20Table%20Leg%20Sleeve


$fn = 128;

//
// Adjustable parameters
//
thickness = 2;             // Minimum sleeve thickness
height = 40;               // Height of sleeve (not including ring gap
topDiameter = 44.1;        // Inside diameter of top half of sleeve
bottomDiameter = 38;       // Inside diameter of bottom half of sleeve
compressionGapWidth = 3.5; // Horizontal compression gap size
ringGap = 2;               // Size of vertical gap separating top and bottom halves
fudge = 0.1;               // Fudge size (needed only for nice rendering)
tabWidth = 4;              // Width of fastener tab
tabDepth = 13;             // Depth of fastener tab
holeDiameter=6.3;          // Diameter of fastener through hole



//
// This part is built by subtracing parts from a cylindrical form with a block for the fastener tab
//
difference () {

    // Solid cylinder and fastener tab
    union(){
        cylinder(h=height+ringGap, r=(topDiameter/2)+thickness);
        translate([-(compressionGapWidth+2*tabWidth)/2,topDiameter/2,0])
            cube([compressionGapWidth+2*tabWidth, thickness+tabDepth, height+ringGap]);
    }

    // Inside cylinders for top and bottom
    translate([0,0,-fudge]) {
        cylinder(h=height+2*fudge+ringGap, r=(bottomDiameter/2));
        cylinder(h=height/2+2*fudge+ringGap, r=(topDiameter/2));
    }

    // Compression gap cut
    translate([-compressionGapWidth/2,0,0])
        cube([compressionGapWidth, (topDiameter/2)+thickness+tabDepth+fudge, height+ringGap]);

    // Ring gap cut
    translate([-(topDiameter+2*(thickness+fudge))/2,-(topDiameter/4),height/2])
        cube([topDiameter+2*(thickness+fudge), (3*topDiameter/4)+thickness+tabDepth+fudge, ringGap]);

    // Fastener holes
    translate([-(2*(tabWidth+fudge)+compressionGapWidth)/2,(topDiameter+2*thickness+tabDepth)/2,height/4])
        rotate(a=[0,90,0])
            cylinder(h=2*(tabWidth+fudge)+compressionGapWidth, r=holeDiameter/2);
    translate([-(2*(tabWidth+fudge)+compressionGapWidth)/2,(topDiameter+2*thickness+tabDepth)/2,3*height/4+compressionGapWidth/2])
        rotate(a=[0,90,0])
            cylinder(h=2*(tabWidth+fudge)+compressionGapWidth, r=holeDiameter/2);



    // Embossed triangular logo
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


