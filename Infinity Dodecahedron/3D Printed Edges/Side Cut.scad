// Regular Dodecahedron Edge Ribs


// Cf. https://github.com/openscad/openscad/issues/4603 for a good discussion
// that helped resolve some of the issues in this design.

$fn = 40;

// Variable parameters to cusomize the edge ribs
paneEdge = ((7 + 1/16) * 25.4) - 5.5; // paneEdge (6in x 25.4 mm/in + adjustment)
edgeThickness = 1.5;   // thickness of the edge
ribWidth = 15;         // width of the rib
paneThickness = 3.25;  // thickness of the pane
channelWidth = 11;     // width of LED strip channel
channelDepth = 1;      // depth of LED strip channel
wireWidth = 3 * 1.6;   // width of wire channel (3x 22 AWG insulated wires)
wireDepth = 1.6;       // depth of wire channel (1x 22 AWG insulated wire)
dihedral = 116.56505;  // angle of polyhedron dihedral
interior = 108.0;      // angle of face interior
fudge = 0.01;          // render artifact elimination fudge factor

// Calculated parameters
edge = 0.667 * ribWidth  * tan(interior / 2) + paneEdge;
echo("pane edge", paneEdge);
echo("edge", edge);

difference() {
    extruded_edge(edge, edgeThickness, ribWidth, paneThickness, channelWidth, channelDepth, wireWidth, wireDepth, dihedral);
    bevel_cuts(ribWidth, interior, dihedral);
    translate([ribWidth,0,edge]) {
        rotate([0,0,180-dihedral]) {
            translate([ribWidth,0,0]) {
                rotate([0,180,0]) {
                    bevel_cuts(ribWidth, interior, dihedral);
                }
            }
        }
    }
}


// Bevel cuts for the end of the rib
module bevel_cuts(ribWidth, interior, dihedral) {
    union() {
        angle_cut(ribWidth, interior);
        translate([ribWidth,0,0]) {
            rotate([0,0,180-dihedral]) {
                translate([ribWidth, 0, 0]) {
                    mirror([1,0,0]) {
                        angle_cut(ribWidth, interior);
                    }
                }
            }
        }
    }
}


// Half of one bevel
module angle_cut(ribWidth, interior) {

    angle_ab = 90 - (interior / 2);

    ax = 0;
    ay = 0;
    az = 0;
    bx = ribWidth;
    by = 0;
    bz = 0;
    cx = 0;
    cy = 0;
    cz = ribWidth * tan(angle_ab);
    dx = 0;
    dy = 20;
    dz = 0;
    ex = ribWidth;
    ey = 20;
    ez = 0;
    fx = 0;
    fy = 20;
    fz = ribWidth * tan(angle_ab);

    polyhedron(
        points=[
            [ax-fudge, ay-fudge, az-fudge], // point a (0)
            [bx, by-fudge, bz],             // point b (1)
            [cx, cy-fudge, cz],             // point c (2)
            [dx-fudge, dy, dz-fudge],       // point d (3)
            [ex, ey, ez],                   // point e (4)
            [fx, fy, fz]                    // point f (5)
        ],
        faces=[
            [0, 3, 5, 2], // face A
            [0, 1, 4, 3], // face B
            [1, 2, 5, 4], // face C
            [3, 4, 5],    // face D
            [0, 2, 1]     // face E
        ],
        convexity=10
    );
};


// Rib extrusion
module extruded_edge(edge, edgeThickness, ribWidth, paneThickness, channelWidth, channelDepth, wireWidth, wireDepth, dihedral) {

    linear_extrude(height=edge, center=false, convexity=10, twist=0, slices=20, scale=1) {
        
        ax = 0;
        ay = 0;
        bx = ribWidth;
        by = 0;
        cx = ribWidth + ribWidth * cos(180 - dihedral);
        cy = ribWidth * sin(180 - dihedral);
        dx = cx - edgeThickness * cos(dihedral - 90);
        dy = cy + edgeThickness * sin(dihedral - 90);
        ex = dx - 0.667 * ribWidth * cos(180 - dihedral);
        ey = dy - 0.667 * ribWidth * sin(180 - dihedral);
        fx = ex - paneThickness * cos(dihedral - 90);
        fy = ey + paneThickness * sin(dihedral - 90);
        gx = fx + 0.667 * ribWidth * cos(180 - dihedral);
        gy = fy + 0.667 * ribWidth * sin(180 - dihedral);
        px = 0;
        py = edgeThickness + paneThickness;
        qx = 0.667 * ribWidth;
        qy = py;
        rx = qx;
        ry = edgeThickness;
        sx = 0;
        sy = ry; 

        angle_opq = atan((gy - py) / gx);  // derived angle of inside edge
        gp = gx / cos(angle_opq);          // total width of inside edge
        gh = 0.5 * (gp - channelWidth);    // width of offset on either side of the LED channel
        ho = gp - 2 * gh;                  // derived width of LED channel (should match specified)
        jm = wireWidth;                    // total width of wire channel
        ij = 0.5 * (ho - jm);              // width of offset on either side of wire channel within the LED channel
        assert(ho == channelWidth, "Derived channel width does not match specified width");
        assert(jm < ho, "Total wire channel width exceeds the width of the LED strip");

        hx = gx - gh * cos(angle_opq);
        hy = gy - gh * sin(angle_opq);
        ix = hx + channelDepth * sin(90 - 2 * angle_opq);
        iy = hy - channelDepth * cos(90 - 2 * angle_opq);
        ox = px + gh * cos(angle_opq);
        oy = py + gh * sin(angle_opq);
        nx = ox + channelDepth * sin(90 - 2 * angle_opq);
        ny = oy - channelDepth * cos(90 - 2 * angle_opq);
        jx = ix - ij * cos(angle_opq);
        jy = iy - ij * sin(angle_opq);
        kx = jx + wireDepth * sin(90 - 2 * angle_opq);
        ky = jy - wireDepth * cos(90 - 2 * angle_opq);
        mx = nx + ij * cos(angle_opq);
        my = ny + ij * sin(angle_opq);
        lx = mx + wireDepth * sin(90 - 2 * angle_opq);
        ly = my - wireDepth * cos(90 - 2 * angle_opq);
                
        polygon([
            [ax, ay], // point 'a'
            [bx, by], // point 'b'
            [qx, qy], // point 'q'
            [rx, ry], // point 'r'
            [sx, sy]  // point 's'
        ]);
    };
};