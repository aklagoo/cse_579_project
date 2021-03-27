% Disallow invalid positions.
:- not cell(X, Y), at(O, I2, X, Y, T).

% Disallow two robots in one cell.
:- at(robot, RI1, X, Y, T), at(robot, RI2, X, Y, T), RI1 != RI2, robot(RI1), robot(RI2).

% Calculate UMAX for each product.
umax(II, UMAX) :- UMAX = #sum{U, IS : inventory(IS, II, U, 0), shelf(IS)}, product(II).