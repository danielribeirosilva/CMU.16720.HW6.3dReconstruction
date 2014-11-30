function H=computeH(ps,qs)
	points = size(ps,1);
	C=[];

	scale = 1;
	ps = ps / scale;

	for i = 1:points
		fr = -[ps(i, 1) * qs(i, :) ps(i, 1)];
		sr = -[ps(i, 2) * qs(i, :) ps(i, 2)];
		C = [C; qs(i, :) 1   0   0  0 fr];
		C = [C;  0   0   0 qs(i, :) 1 sr];
	end

	[U, S, V] = svd( C );
	VV = V(:,9);
	VV = VV / norm(VV);

	%fprintf('%.10e\n', norm(C * VV));

	H = [ VV(1:3)' ; VV(4:6)' ; VV(7:9)' / scale ];
	H = H / norm(H);

end
