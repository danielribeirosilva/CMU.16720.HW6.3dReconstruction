function [plane] = getPlane(P1, P2, P3)
    
    normal = cross(P2-P1, P3-P1);
    d = - dot(normal, P1);
    
    plane = [normal d];
    plane = plane/norm(plane);
end