% =====================================================================
% ACTION DEFINITIONS AND CONSTRAINTS
% =====================================================================
% 0. BASE DEFINITIONS
% ---------------------------------------------------------------------
% Define the range of possible directions.
direction(DX, DY) :- DX=-1..1, DY=-1..1, |DX|!=|DY|.

% =====================================================================
% A. MOVE
% ---------------------------------------------------------------------
% Update robot's location and move shelf along with itself if it's
% carrying one.
% ---------------------------------------------------------------------
at(robot, IR, X+DX, Y+DY, T+1) :- move(IR, DX, DY, T),
        at(robot, IR, X, Y, T),
        robot(IR), direction(DX, DY).
at(shelf, IS, X+DX, Y+DY, T+1) :- move(IR, DX, DY, T),
        at(robot, IR, X, Y, T), isCarrying(t, IR, IS, T),
        robot(IR), shelf(IS), direction(DX, DY).

% ---------------------------------------------------------------------
% Disable movement onto another shelf if carrying shelf.
% ---------------------------------------------------------------------
:- at(robot, I, X, Y, T), move(I, DX, DY, T), isCarrying(t, IR, IS, T),
        at(shelf, ISS, X+DX, Y+DY, T),
        robot(IR), shelf(IS), shelf(ISS).

% ---------------------------------------------------------------------
% Disable switching of positions between robots.
% ---------------------------------------------------------------------
:- at(robot, I1, X, Y, T), at(robot, I2, X+DX, Y+DY, T),
        move(I1, DX, DY, T), move(I2, -DX, -DY, T),
        direction(DX, DY).

% =====================================================================
% B. PICK UP
% ---------------------------------------------------------------------
% Set isCarrying on pickUp if the following conditions are true:
% 1. Both robot IR and shelf IS are at (X, Y).
% 2. Robot IR isn't already carrying shelf IS.
% ---------------------------------------------------------------------
isCarrying(t, IR, IS, T+1) :- pickUp(IR, T),
        at(robot, IR, X, Y, T), at(shelf, IS, X, Y, T),
        not isCarrying(t, IR, IS, T).

% =====================================================================
% C. DELIVER
% ---------------------------------------------------------------------
% Decrement suborder product counter and inventory by U on
% deliver(IR, IO, II, U, T) if the following conditions are true:
% 1. Order IO has been assigned the Picking Station IP.
% 2. Picking station IP and robot IR are both at (X, Y).
% 3. Robot IR is carrying shelf IS.
% 4. Shelf IS carries USH units of product II.
% 5. Suborder (IO, II) needs USUB units of product II.
% 6. U <= USH, U <= USUB.
% ---------------------------------------------------------------------
suborder(IO, II, USUB - U, T+1) :- deliver(IR, IO, II, U, T),
        order(IO, IP),
        at(robot, IR, X, Y, T), pickingStation(IP, X, Y),
        isCarrying(t, IR, IS, T),
        inventory(IS, II, USH, T), suborder(IO, II, USUB, T),
        U <= USH, U <= USUB.

inventory(IS, II, USH - U, T+1) :- deliver(IR, IO, II, U, T),
        order(IO, IP),
        at(robot, IR, X, Y, T), pickingStation(IP, X, Y),
        isCarrying(t, IR, IS, T),
        inventory(IS, II, USH, T), suborder(IO, II, USUB, T),
        U <= USH, U <= USUB.

% =====================================================================
% D. PUT DOWN
% ---------------------------------------------------------------------
% Set isCarrying to false on putDown(IR, T) if the following conditions
% are true:
% 1. Robot IR is at location (X, Y).
% 2. Location (X, Y) is not a highway.
% 3. Robot IR is carrying shelf IS.
isCarrying(f, IR, IS, T+1) :- putDown(IR, T),
        at(robot, IR, X, Y, T), not highway(X, Y),
        isCarrying(t, IR, IS, T),
        robot(IR), shelf(IS).
