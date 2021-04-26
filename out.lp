occurs(object(robot, IR), move(DY, DX), T) :- move(IR, DX, DY, T), active_timestep(T).
occurs(object(robot, IR), pickup, T) :- pickUp(IR, T), active_timestep(T).
occurs(object(robot, IR),deliver(IO, II, U), T) :- deliver(IR, IO, II, U, T), active_timestep(T).
occurs(object(robot, IR), putdown, T) :- putDown(IR, T), active_timestep(T).
#show occurs/3.