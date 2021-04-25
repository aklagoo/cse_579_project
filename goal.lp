% =====================================================================
% GOAL AND OPTIMIZATION DEFINITION
% =====================================================================
% A. GOAL DEFINITION
% ---------------------------------------------------------------------
% At time step t, there should not be a single suborder with quantity
% that is not zero.
% ---------------------------------------------------------------------
goal(X, T) :- X = #sum{U, IO, II: suborder(IO, II, U, T)}, T=0..t.
:- not goal(0, t).

% =====================================================================
% B. OPTIMIZATION CONSTRAINTS
% ---------------------------------------------------------------------
% Minimize the number of timesteps where the goal is not zero.
% ---------------------------------------------------------------------
active_timestep(T) :- goal(X, T), X!=0.
#minimize{1, T : active_timestep(T)}.