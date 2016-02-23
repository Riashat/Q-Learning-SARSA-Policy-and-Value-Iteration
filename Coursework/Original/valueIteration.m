function [v, pi] = valueIteration(model, maxit)

% initialize the value function
v = zeros(model.stateCount, 1);

for i = 1:maxit,
    % initialize the policy and the new value function
    pi = ones(model.stateCount, 1);
    v_ = zeros(model.stateCount, 1);

    % perform the Bellman update for each state
    for s = 1:model.stateCount,
        % COMPUTE THE VALUE FUNCTION AND POLICY
        % YOU CAN ALSO COMPUTE THE POLICY ONLY AT THE END
    end

    v = v_;

    % exit early
    if 0,
        % CHANGE THE IF-STATEMENT
        break;
    end
end

