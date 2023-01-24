$fn=100;
fudge=0.01;



capturedButton(0.2, 2, 12, 3, 2);

module capturedButton(gap, radius, shaftLength, buttonHeight, throwLength) {
    
    minimumHeight = 8 * gap + buttonHeight + throwLength;
    
    shaftLen = (shaftLength < minimumHeight) ? minimumHeight : shaftLength;

    minInternalThickness = 1;
    

    difference() {
        union() {
                difference() {
                    cylinder(h=minimumHeight+2*gap,r=radius+6*gap+minInternalThickness); // outside cylinder
                    taperedCylinder(gap, radius+gap, minimumHeight+2*gap+fudge, 0, buttonHeight+throwLength); // inside clearanc

                }

          taperedCylinder(gap, radius, shaftLen, buttonHeight, throwLength); // plunger
            }
        //translate([-(radius+6*gap+minInternalThickness),0,-fudge]){cube([2*(radius+6*gap+minInternalThickness),radius+6*gap+minInternalThickness,shaftLen+2*fudge]);} // cross-sectional cut

    }

}


module taperedCylinder(gap, shaftRadius, shaftLength, buttonHeight, throwLength) {
  cylinder(h=shaftLength,r=shaftRadius); 
  translate([0,0,buttonHeight]) {
     
     cylinder(h=4*gap,r1=shaftRadius,r2=shaftRadius+4*gap);
     if (throwLength > 0) {
        translate([0,0,4*gap-fudge]) {
            cylinder(h=throwLength,r1=shaftRadius+4*gap,r2=shaftRadius+4*gap);
        }
     }
     translate([0,0,4*gap+throwLength-2*fudge]) {
        cylinder(h=4*gap,r1=shaftRadius+4*gap,r2=shaftRadius);
     }
 }
}