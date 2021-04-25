occurs(object(robot, IR), move(DY, DX), T) :- move(IR, DX, DY, T).
occurs(object(robot, IR), pickup, T) :- pickUp(IR, T).
occurs(object(robot, IR),deliver(IO, II, U), T) :- deliver(IR, IO, II, U, T).
occurs(object(robot, IR), putdown, T) :- putDown(IR, T).
#show occurs/3.