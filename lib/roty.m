function r = roty(angle)
    r = angle*pi/180;
    r = [cos(r) 0 sin(r); 0 1 0; -sin(r) 0 cos(r)];
end