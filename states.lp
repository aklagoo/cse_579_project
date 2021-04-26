% Disallow invalid positions.
:- not cell(X, Y), at(O, I2, X, Y, T).

% Disallow two robots in one cell.
:- at(robot, RI1, X, Y, T), at(robot, RI2, X, Y, T), RI1 != RI2, robot(RI1), robot(RI2).