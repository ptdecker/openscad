
edge = 150;           // length of edge
edgeThickness = 1.5;  // thickness of the edge
ribWidth = 15;        // width of the rib
paneThickness = 3.25; // thickness of the pane
channelWidth = 11;    // width of LED strip channel
channelDepth = 1;     // depth of LED strip channel
wireWidth = 3 * 1.6;  // width of wire channel (3 22 AWG insulated wires)
wireDepth = 1.6;      // depth of wire channel (1 22 AWG insulated wire)
dihedral = 116.56505; // angle of polyhedron dihedral


linear_extrude(height=edge, center=false, convexity=0, twist=0, slices=20, scale=1) {
    
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
        [cx, cy], // point 'c'
        [dx, dy], // point 'd'
        [ex, ey], // point 'e'
        [fx, fy], // point 'f'
        [gx, gy], // point 'g'
        [hx, hy], // point 'h'
        [ix, iy], // point 'i'
        [jx, jy], // point 'j'
        [kx, ky], // point 'k'
        [lx, ly], // point 'l'
        [mx, my], // point 'm'
        [nx, ny], // point 'n'
        [ox, oy], // point 'o'
        [px, py], // point 'p'
        [qx, qy], // point 'q'
        [rx, ry], // point 'r'
        [sx, sy]  // point 's'
    ]);
}
    