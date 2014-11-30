function inside_id = inside_polygon(ps, check_ps)
	%assumes convex polygon

	order = convhull(ps(:, 1), ps(:, 2));
	ls = [];
	signs = [];
	centroid = mean(ps);
	for u=1:numel(order) - 1
		p1 = ps( order(u), :);
		p2 = ps( order(u + 1), :);

		%l = cross([p1 1], [p2 1]);
		l = [p1(2) - p2(2), p2(1) - p1(1), p1(1) * p2(2) - p2(1) * p1(2)];
		l = l / norm(l);
		s = l * [centroid 1]';

		ls = [ls; l];
		signs = [signs s];
	end

	signs( signs > 0 ) = 1;
	signs( signs < 0 ) = -1;

	res = [check_ps repmat(1, size(check_ps, 1), 1)] * ls';
	res( res > 0 ) = 1;
	res( res < 0 ) = -1;

	res_compare = repmat(signs, size(check_ps, 1), 1);

	results = (res == res_compare);
	results = sum(results, 2);
	inside_id = find(results == numel(order) - 1);
end
