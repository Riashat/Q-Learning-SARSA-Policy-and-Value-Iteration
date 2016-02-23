% Adapted by C E Rasmussen from earlier work by F Doshi and M P Deisenroth

% ----- Introduction ----- %

% The model is a gridworld (i.e., checkerboard).  The goal is to travel
% from some (specified) start location to some (specified) final location
% to receive a large reward.  Each action has unit cost, but there may be
% some 'pitfall' locations with large penalties.  The gridbot has four
% control actions: up, down, left, and right.  The execution of these
% actions is noisy, but once completed, the gridbot knows its new state.

% For your convenience, you can use the following variables instead of
% having to use the indices for each action:
aUp = 1;
aDown = 2;
aLeft = 3;
aRight = 4;

% ----- Initialise a true model ----- %

% set the size of the gridworld (rows and columns) as well as any
% obstructed cells (each row is a (row, col) pair of an obstructed block)
paramSet.colCount = 10;
paramSet.rowCount = 5;
paramSet.obsSet = [1 10; 2 10; 3 10; 4 10; 5 10];
paramSet.startState = [5 1];
paramSet.goalState = [5 9];
paramSet.badSet = [5 2; 5 3; 5 4; 5 5; 5 6; 5 7; 5 8]; 

% set the transition properties of the gridbot: pGoodTrans is the
% probability that the gridbot does the desired action.  Otherwise, with
% probability ( 1 - pGoodTrans )*bias, it goes left of the desired action
% and (1-pGoodTrans)*(1-bias), it goes right of the desired action.
paramSet.pGoodTrans = 1.0;
paramSet.bias = 0; 

% set the reward parameters: rStep is the cost of an action, rGoal is the
% reward associated with reaching the goal, and rBad is the reward for
% passing through a bad spot.
paramSet.rStep = -1;
paramSet.rGoal = 10;
paramSet.rBad = -6;
paramSet.gamma = 0.9;

% creates a model based on the parameters.  The fields are given by:
model = initGridworld( paramSet );

% modify the transition model so that any actions taken from the "cliff" states
% will transition back to the start state.
for rc = paramSet.badSet',
    s1 = rc2s(rc, paramSet.colCount);
    s2 = rc2s(paramSet.startState, paramSet.colCount);
    model.P(s1, :, :) = 0;
    model.P(s1, s2, :) = 1;
end

