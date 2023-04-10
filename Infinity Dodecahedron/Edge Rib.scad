
edge = 20;            // length of edge
edgeThickness = 1.5;  // thickness of the edge
ribWidth = 18;        // width of the rib
paneThickness = 3.25; // thickness of the pane
channelWidth = 10;    // width of LED strip channel
channelDepth = 1;     // depth of LED strip channel


ribThick = 5;
dihedral = 116.56505;



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


    angle_opq = atan((gy - py) / gx);
    echo("angle_opq:", angle_opq);
    inside_width = gx * cos(angle_opq);
    echo("inside_width:", inside_width);

    hx = gx - 0.5 * (inside_width - channelWidth) * cos(angle_opq);
    hy = gy - 0.5 * (inside_width - channelWidth) * sin(angle_opq);
    ix = hx + channelDepth * sin(90 - 2 * angle_opq);
    iy = hy - channelDepth * cos(90 - 2 * angle_opq);

    ox = px + 0.5 * (inside_width - channelWidth) * cos(angle_opq);
    oy = py + 0.5 * (inside_width - channelWidth) * sin(angle_opq);
    nx = ox + channelDepth * sin(90 - 2 * angle_opq);
    ny = oy - channelDepth * cos(90 - 2 * angle_opq);
    
    jx = nx;
    jy = ny;
    kx = nx;
    ky = ny;
    lx = nx;
    ly = ny;
    mx = nx;
    my = ny;
    

    
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
    