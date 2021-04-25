% =====================================================================
% CONVERT INPUT AND DEFINE BASIC DATA.
% =====================================================================
% A. INPUT CONVERSION
% ---------------------------------------------------------------------
% We have 3 locations:
% 1. node(X, Y)
% 2. highway(X, Y)
% 3. pickingStation(IP, X, Y)
% ---------------------------------------------------------------------
cell(X, Y) :- init(object(node, I), value(at,pair(X,Y))).
highway(X, Y) :- init(object(robot, I), value(at,pair(X,Y))).
pickingStation(IP, X, Y) :- init(object(pickingStation, IP), value(at,pair(X,Y))).

% ---------------------------------------------------------------------
% We have 2 mobile objects:
% 1. robot, robot(IR), at(robot, IR, X, Y, T)
% 2. shelf, shelf(IS), at(shelf, IS, X, Y, T)
% ---------------------------------------------------------------------
at(robot, IR, X, Y, 0) :- init(object(robot, IR), value(at,pair(X,Y))).
robot(IR) :- init(object(robot, IR), value(at,pair(X,Y))).

at(shelf, IS, X, Y, 0) :- init(object(shelf, IS), value(at,pair(X,Y))).
shelf(IS) :- init(object(shelf, IS), value(at,pair(X,Y))).

% ---------------------------------------------------------------------
% We have 3 order objects:
% 1. product(II), inventory(IS, II, U, T)
% 2. order(IO, IP), suborder(IO, II, U, T)
% ---------------------------------------------------------------------
order(IO, IP) :- init(object(order, IO),value(pickingStation, IP)).
suborder(IO, II, U, 0) :- init(object(order, IO), value(line, pair(II, U))).
order_product_pair(IO, II) :- init(object(order, IO), value(line, pair(II, U))).

product(II) :- init(object(product, II), value(on, pair(IS, U))).
inventory(IS, II, U, 0) :- init(object(product, II), value(on, pair(IS, U))).
shelf_product_pair(IS, II) :- init(object(product, II), value(on, pair(IS, U))).

% =====================================================================
% B. DATA INITIALIZATION
% ---------------------------------------------------------------------
% Define basic data.
% ---------------------------------------------------------------------
boolean(true; false).

% ---------------------------------------------------------------------
% Define flags.
% ---------------------------------------------------------------------
isCarrying(false, IR, IS, 0) :- robot(IR), shelf(IS).