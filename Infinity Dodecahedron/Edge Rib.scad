ribWidth = 15; 
ribThick = 5;
paneThick = 3;
dihedral = 116.56505;


linear_extrude(height=3, center=false, convexity=0, twist=0, slices=20, scale=1) {
    
    a = sin(dihedral -  90) * ribWidth;
    b = cos(dihedral -  90) * ribWidth;
    c = sin(180 - dihedral) * ((ribThick / 2) - (paneThick / 2));
    d = cos(180 - dihedral) * ((ribThick / 2) - (paneThick / 2));
    e = sin(dihedral -  90) * (ribWidth / 3);
    f = cos(dihedral -  90) * (ribWidth / 3);
    g = sin(180 - dihedral) * paneThick;
    h = cos(180 - dihedral) * paneThick;
    i = sin(180 - dihedral) * ((ribThick / 2) + (paneThick / 2));
    j = cos(180 - dihedral) * ((ribThick / 2) + (paneThick / 2));
    
    polygon([
        [0,0],                                                  // a
        [-a,b],                                                 // b
        [-a+c, b+d],                                            // c
        [-e+c, f+d],                                            // d
        [-e+g, f+h],                                            // e
        [-a+i-c, b+j-d],                                        // f
        //[-a+i, b+j],                                            // g
        //[ribWidth, ribThick],                                   // h
        [ribWidth, (ribThick / 2) + (paneThick / 2)],           // i
        [(ribWidth / 3), (ribThick / 2) + (paneThick / 2)],     // j
        [(ribWidth / 3), (ribThick / 2) - (paneThick / 2)],     // k
        [ribWidth, (ribThick / 2) - (paneThick / 2)],           // l
        [ribWidth,0]                                            // m
    ]);
}
    