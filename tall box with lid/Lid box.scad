
boxAndLid(2 + 15/32, 0.75, 3 + 5/8);

inchesToMM = 25.4;
ad = 0; // adjustment needed for nice OpenSCAD rendering (0 if using Minkowski sum)

module boxAndLid(width, depth, height, thickness = 3) {

    // convert dimensions from inches to mm and adjust for thickness plus margin
    w =  width * inchesToMM + (2 * thickness) + 2;
    d =  depth * inchesToMM + (2 * thickness) + 2;
    h = height * inchesToMM + (2 * thickness) + 2;
    t = thickness;
    
    dh = h * 0.8; // bottom height proportion
    lh = 20;      // lip height (mm)
    gt = 0.9;     // gap tollerance (mm)

    minkowski() {
        boxBottom(w, d, h, dh, lh, t, gt / 2);
        sphere(0.25);
    }
    
    translate([0, d * 2, 0]) {
        minkowski() {
            boxTop(w, d, h, dh, lh, t, gt - gt / 2);
            sphere(0.25);
        }
    }
}

module boxBottom(w, d, h, dh, lh, t, gt) {
    difference() {
        cube([w, d, dh]);
        translate([t, t, t]) cube([w - 2 * t, d - 2 * t, dh + lh - t + ad]);
        translate([-ad, -ad, dh - lh]) cutout(w + 2 * ad, d + 2 * ad, lh + ad, t / 2, gt);
    }
}

module boxTop(w, d, h, dh, lh, t, gt) {
    union() {
        difference() {
            cube([w, d, (h - dh)]);
            translate([t, t, t]) cube([w - 2 * t, d - 2 * t, h - dh - t + ad]);
        }
        translate([0, 0, (h - dh)]) cutout(w, d, lh, t / 2, -gt);
    }
}

module cutout(w, d, h, t, gt = 0) {
    difference() {
        cube([w, d, h]);
        translate([t + gt, t + gt, -ad]) cube([w - 2 * (t + gt), d - 2 * (t + gt), h + 2 * ad]);
    }
}