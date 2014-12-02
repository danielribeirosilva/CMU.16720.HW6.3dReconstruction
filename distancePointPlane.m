function d = distancePointPlane(point, plane)
    if size(point,1)>1
        point = point';
    end
    
    if size(plane,1)>1
        plane = plane';
    end
    
    d =  abs(dot([point 1],plane))/norm(plane(1:3));
end