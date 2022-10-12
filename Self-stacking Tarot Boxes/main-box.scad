
// 3" = 3.014"

//cardBox(3.25, 5.7, 1.500);  // Regular deck box
//cardBox(3.25, 5.7, 0.750);  // Shallow deck box
//cardBox(3.25, 5.7, 2.375);  // Tall deck box  3.125 
//cardBox(4.25, 7.5, 2.250);  // Wide deck box

//lid(3.25, 5.7); // Shallow, regular, and tall deck box lid
lid(4.25, 7.5); // Wide deck box lid


inchesToMM = 25.4;

function cubePoints(w, d, t) = [
    [t,t,0],     // 0 Bottom A 
    [w-t,t,0],   // 1 Bottom B
    [w-t,d-t,0], // 2 Bottom C
    [t,d-t,0],   // 3 Bottom D
    [0,0,t],     // 4 Top A
    [w,0,t],     // 5 Top B
    [w,d,t],     // 6 Top C
    [0,d,t]];    // 7 Top D

function cubeFaces() = [
    [0,1,2,3],   // Bottom
    [4,5,1,0],   // Front
    [7,6,5,4],   // Top
    [5,6,2,1],   // Right
    [6,7,3,2],   // Back
    [7,4,0,3]];  // Left

module lid(width, depth, thickness = 3) {

    w  = (width * inchesToMM);
    d  = (depth * inchesToMM);
    t  = thickness;
    fd = ( 0.375 * inchesToMM);

    difference() {
        union() {
            cube([w, d, t]);
            translate([0, 0, -t]) polyhedron(cubePoints(w, d, t), cubeFaces());
            translate([t, t, -t*(3/2)]) cube([w - 2 * t, d - 2*t, t/2]);
        } 
        translate([w/2,fd,-t*(3/2)-0.02]) cylinder((5/2) * t + 0.04, fd + t/2, fd, $fn=100);
        translate([w/2,0,-(t/3)-0.02]) cube([2*fd,2*fd,(5/2) * t + 1],center=true);          
    }
}

module cardBox(width, depth, height, thickness = 3) {

    w = ( width * inchesToMM);
    d = ( depth * inchesToMM);
    h = (height * inchesToMM);
    t = thickness;

    difference () {
        cube([w, d, h]);
        translate([t,t,-.01]) cube([w - 2 * t, d - 2 * t, h+0.02]);
        translate([0,0,h-t+.01]) polyhedron(cubePoints(w, d, t), cubeFaces());
    }
    translate([0,0,-t]) polyhedron(cubePoints(w, d, t), cubeFaces());
    translate([t,t,-t*(3/2)]) cube([w - 2 * t, d - 2*t, t/2]) ;
}