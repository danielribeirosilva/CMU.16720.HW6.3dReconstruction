function r = rotx(angle)
    r = angle*pi/180;
    r = [1 0 0; 0 cos(r) -sin(r); 0 sin(r) cos(r)];
end