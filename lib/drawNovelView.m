%draws novel view of smith hall given a camera matrix and the parameters of the planes of smith hall
%does not take into account distances of planes, so if you move your camera to the "back" of smith hall, then the two planes may overlap in an odd manner
function frame = drawNovelView(smith_south_plane, smith_west_plane, M)
	load('K.mat'); %K
	i1 = imread('data/i1.jpg');
	all_planes(1).eq = smith_south_plane';
	all_planes(1).p_boundary = [1173 67; 81 564; 39 924; 1203 1076];

	all_planes(2).eq = smith_west_plane';
	all_planes(2).p_boundary = [1173 67; 1785 461; 1832 970; 1203 1076];

	M1 = K * eye(3, 4);

	warp_im = uint8(zeros(1080, 1920, 3));
	for u=1:numel(all_planes)
		[X, Y] = meshgrid(1:size(i1,2), 1:size(i1,1));
		ret = inside_polygon( all_planes(u).p_boundary, [X(:) Y(:)] );
		mask = false(size(i1,1), size(i1,2));
		mask( ret ) = true;

		eq = all_planes(u).eq;
		pts = all_planes(u).p_boundary;
		mapped = [];
		for v=1:size(pts, 1)
			plane1 = M1(1,:) - pts(v, 1) * M1(3,:);
			plane2 = M1(2,:) - pts(v, 2) * M1(3,:);
			plane1 = plane1 / norm(plane1);
			plane2 = plane2 / norm(plane2);
			A = [plane1; plane2; eq];
			pts3D = -(A(1:3, 1:3)) \ A(:, 4);
			remap = M * [pts3D; 1];
			mapped = [mapped; remap(1:2)' / remap(3)];
		end
		H = computeH(mapped, pts);
		for v=1:3
			tp = i1(:, :, v);
			tp( ~mask ) = 0;
			i1_filtered(:,:,v) = tp;
		end
		warp_im = warp_im + warpH(i1_filtered, H, [1080 1920], 0);
	end
	frame = warp_im;
end

