function r = rotz(angle)
    r = angle*pi/180;
    r = [cos(r) -sin(r) 0; sin(r) cos(r) 0; 0 0 1];
end