$fn=100;
fudge=0.01;


lightTube(21,2.25);

module lightTube(height, radius, lipClearance=1, layerDimension=0.15) {
    union() {
        difference() {
            cylinder(h=height, r=radius);
            cylinder(h=height+fudge, r=radius-2*layerDimension);
        }
        cylinder(h=layerDimension, r=radius+lipClearance);
    }
}
    