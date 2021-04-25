% =====================================================================
% DOMAIN INDEPENDENT AXIOMS
% =====================================================================
% Uniqueness constraints.
% ---------------------------------------------------------------------
:- not 1{at(robot, IR, X, Y, T)}1, robot(IR), T=1..t.
:- not 1{at(shelf, IS, X, Y, T)}1, shelf(IS), T=1..t.
:- not 1{isCarrying(B, IR, IS, T) : boolean(B)}1, robot(IR), shelf(IS),
        T=1..t.
:- not 1{suborder(IO, II, U, T)}1, order_product_pair(IO, II), T=1..t.
:- not 1{inventory(IS, II, U, T)}1, shelf_product_pair(IS, II), T=1..t.

% =====================================================================
% Actions are exogenous.
% ---------------------------------------------------------------------
{move(IR, DX, DY, T)} :- robot(IR), direction(DX, DY), T=0..t-1.
{pickUp(IR, T)} :- robot(IR), T=0..t-1.
{deliver(IR, IO, II, U, T)} :- robot(IR), order(IO, IP), product(II),
        umax(II, UMAX), U = 1..UMAX, T=0..t-1.
{putDown(IR, T)} :- robot(IR), T=0..t-1.

% =====================================================================
% Law of Inertia for all entities
% ---------------------------------------------------------------------
{at(robot, IR, X, Y, T+1)} :- robot(IR), at(robot, IR, X, Y, T),
        T = 0..t-1.
{at(shelf, IS, X, Y, T+1)} :- shelf(IS), at(shelf, IS, X, Y, T),
        T = 0..t-1.
{isCarrying(B, IR, IS, T+1) : boolean(B)} :- isCarrying(B, IR, IS, T),
        robot(IR), shelf(IS),
        T=0..t-1.
{suborder(IO, II, U, T+1)} :- suborder(IO, II, U, T), order(IO, IP),
        pickingStation(IP, X, Y), product(II),
        T=0..t-1.
{inventory(IS, II, U, T+1)} :- inventory(IS, II, U, T),
        shelf(IS), product(II),
        T = 0..t-1.