function model = initGridworld( paramSet )
% Creates a model based on the parameters.  Each cell is a state, numbered
% from 1...n across rows and then down columns.  Obstructed states are
% treated as states that can never be entered.  For computational
% convenience, the obstructed states and goal state transition to a
% fictional absorbing end state.  
% 
% QUESTION FOR ATTENDEES: WHY IS THIS
% IMPORTANT FOR IMPLEMENTING VALUE ITERATION?
%
% The model output consists of:
% * model.P( s, s', a ) is the transition probability from s to s' given
% action a.  
% * model.R( s, a ) is the reward for performing a in s.
% * model.stateCount = number of states, including fictional end state

% set state count
model.stateCount = paramSet.colCount * paramSet.rowCount + 1;
model.gamma = paramSet.gamma;
model.startState = rc2s(paramSet.startState, paramSet.colCount);
model.goalState = rc2s(paramSet.goalState, paramSet.colCount);

% set the rewards for each state
model.R = repmat( paramSet.rStep, [ model.stateCount, 4 ] );
model.R( model.stateCount, : ) = 0;
goalState = rc2s( paramSet.goalState , paramSet.colCount );
model.R( goalState, : ) = paramSet.rGoal;
for i = 1:size( paramSet.badSet , 1 )
    badState = rc2s( paramSet.badSet( i , : ) , paramSet.colCount );
    model.R( badState, : ) = paramSet.rBad;
end

% set the transition probabilities for each s , s', a (note: this isn't a
% particularly efficient implementation, but it should be clear how we are
% constructing the model!)
model.P = zeros( model.stateCount, model.stateCount, 4 ); 
for a = 1:4
    for s = 1:model.stateCount
        
        % check if s is end state - self transition
        if s == model.stateCount 
            model.P( s , s , a ) = 1;
            continue;
        end
            
        % check if s is a goal or an obstructed state - transition to end
        rc = s2rc( s , paramSet.colCount );
        endSet = [ paramSet.obsSet ; paramSet.goalState ];
        if any( sum( abs( ...
                endSet - repmat( rc , size(endSet,1), 1 ...
                ) ) , 2 ) == 0 )
            model.P( s , model.stateCount, a ) = 1;
        
        % else consider stochastic effects of action    
        else
            for ang = -1:1:1
                dir = getDir( a , ang );
                sout = getState( s , dir , paramSet );
                switch ang
                    case 0, p = paramSet.pGoodTrans; 
                    case -1, p = (1-paramSet.pGoodTrans)*(paramSet.bias); 
                    case 1, p = (1-paramSet.pGoodTrans)*(1-paramSet.bias); 
                end
                model.P( s, sout, a ) = model.P( s, sout, a ) + p;
            end
        end
    end
end

% ---------------------------------------------------------------------- %
function sout = getState( s, dir , paramSet )
% takes in a state, direction, and gives deterministic result of action
cLUT = [0 0 -1 1];
rLUT = [-1 1 0 0];
rc = s2rc( s , paramSet.colCount );
rc(1) = rc(1) + rLUT( dir );
rc(2) = rc(2) + cLUT( dir );

% check if invalid state
if ( any( rc < 1 ) || ...
        any( rc(:,1) > paramSet.rowCount ) || ...
        any( rc(:,2) > paramSet.colCount ) || ...
        any( sum( abs( paramSet.obsSet - repmat( rc , size( paramSet.obsSet,1), 1 ...
        ) ) , 2 ) == 0 ) )
    sout = s;

% else
else
    sout = rc2s( rc, paramSet.colCount );
end


% ---------------------------------------------------------------------- %
function dir = getDir( a, ang )
% takes in a direction and -1, 0, 1 and converts to another direction
leftLUT = [3 4 2 1];
rightLUT = [4 3 1 2];
if ang == 0
    dir = a;
elseif ang == -1
    dir = leftLUT( a );
elseif ang == 1;
    dir = rightLUT( a );
end


