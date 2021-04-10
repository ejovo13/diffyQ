function integral_curves(anonFunction)

sq_min = -10;
sq_max = 10;
n_steps = 5;


x = linspace(sq_min, sq_max, n_steps);
y = linspace(sq_min, sq_max, n_steps);


[X, Y] = meshgrid(x, y);
U = ones(size(X));
V = anonFunction(X, Y);

norm = sqrt(1 + V.^2);

U = U./norm;
V = V./norm;
alpha = atan2(V, U);
epsilon = pi/32;

starting_id = or(abs(alpha) < epsilon, abs(alpha) - pi/2 < epsilon);

sx = X(starting_id);
sy = Y(starting_id);

[sx, sy] = meshgrid(sx, sy);

streamline(X, Y, U, V, sx, sy);


end


