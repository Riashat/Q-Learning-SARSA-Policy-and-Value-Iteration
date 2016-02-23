function [v, pi] = sarsa(model, maxit, maxeps)

% initialize the value function
Q = zeros(model.stateCount, 4);

for i = 1:maxeps,
    % every time we reset the episode, start at the given startState
    s = model.startState;

    for j = 1:maxit,
        % PICK AN ACTION
        a = 1;
        p = 0;
        r = rand;

        for s_ = 1:model.stateCount,
            p = p + model.P(s, s_, a);
            if r <= p,
                break;
            end
        end

        % s_ should now be the next sampled state.
        % IMPLEMENT THE UPDATE RULE FOR Q HERE.

        % SHOULD WE BREAK OUT OF THE LOOP?
    end
end

% REPLACE THESE
v = zeros(model.stateCount, 1);
pi = ones(model.stateCount, 1);

