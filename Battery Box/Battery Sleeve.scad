fudge = 0.01;

insideWidth = 151;
insideDepth = 155;
insideHeight = 134;
thickness = 4;
reliefWidth = 45;
reliefinsideDepth = 2;

union() {

    // Top
    difference() {
        cube([insideWidth,insideDepth+2*thickness,thickness]); // Top plate
        translate([0,-fudge,-fudge]) {
            cube ([reliefWidth,insideDepth+2*thickness+2*fudge,reliefinsideDepth+fudge]); // Top plate relief
        }
    }


    // Side A
    translate([0,thickness,-insideHeight+thickness]) {
        rotate([90,0,0]) {
            difference() {
                cube([insideWidth,insideHeight,thickness]); // Side plate
                translate([0,-fudge,-fudge]) {
                    cube([reliefWidth,insideHeight+2*fudge,reliefinsideDepth+fudge]);
                }
            }
        }
    }


    // Side B
    translate([0,insideDepth+thickness,thickness]) {
        rotate([-90,0,0]) {
            difference() {
                cube([insideWidth,insideHeight,thickness]); // Side plate
                translate([0,-fudge,-fudge]) {
                    cube([reliefWidth,insideHeight+2*fudge,reliefinsideDepth+fudge]);
                }
            }
        }
    }

    // Divider A
    for (i=[1:3]) {
        translate([reliefWidth,i*((insideWidth-2*thickness)/4)+(i-1)*thickness+thickness,-insideHeight/4+thickness]) {
            cube([(insideWidth-reliefWidth),thickness,insideHeight/4]);
        }
    }

}
