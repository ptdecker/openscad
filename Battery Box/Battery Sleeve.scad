fudge = 0.01;

width = 151;
depth = 155;
heigth = 134;
thickness = 4;
reliefWidth = 45;
reliefDepth = 2;

union() {

    // Top
    difference() {
        cube([width,depth,thickness]); // Top plate
        translate([0,-fudge,-fudge]) {
            cube ([reliefWidth,depth+2*fudge,reliefDepth+fudge]); // Top plate relief
        }
    }


    // Side A
    translate([0,thickness,-heigth+thickness]) {
        rotate([90,0,0]) {
            difference() {
                cube([width,heigth,thickness]); // Side plate
                translate([0,-fudge,-fudge]) {
                    cube([reliefWidth,heigth+2*fudge,reliefDepth+fudge]);
                }
            }
        }
    }


    // Side B
    translate([0,depth-thickness,thickness]) {
        rotate([-90,0,0]) {
            difference() {
                cube([width,heigth,thickness]); // Side plate
                translate([0,-fudge,-fudge]) {
                    cube([reliefWidth,heigth+2*fudge,reliefDepth+fudge]);
                }
            }
        }
    }

    // Divider A
    for (i=[1:3]) {
        translate([reliefWidth,i*((width-2*thickness)/4)+(i-1)*thickness,-heigth+thickness]) {
            cube([(width-reliefWidth),thickness,heigth]);
        }
    }

}
