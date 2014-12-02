function M = buildM(K, rx, ry, rz, tx, ty, tz)
    r = rotx(rx)*roty(ry)*rotz(rz);
    M = K*[r [tx;ty;tz]];
end