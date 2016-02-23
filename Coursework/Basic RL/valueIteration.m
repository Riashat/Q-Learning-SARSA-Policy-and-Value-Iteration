function [v, pi] = valueIteration(model, maxit)
% initialize the value function
v = zeros(model.stateCount, 1);
pi = ones(model.stateCount, 1);
old_v = zeros(model.stateCount, 1);
threshold =  1.0000e-22;

% Cum_Rwd = zeros(maxit, 1);

for iterations = 1:maxit,
    % initialize the policy and the new value function
    policy = ones(model.stateCount, 1);
    v_ = zeros(model.stateCount, 1);
    % perform the Bellman update for each state
    for s = 1:model.stateCount,
        % COMPUTE THE VALUE FUNCTION AND POLICY
        % YOU CAN ALSO COMPUTE THE POLICY ONLY AT THE END
        P = reshape(model.P(s,:,:), model.stateCount, 4);          
        [v_(s,:), action] = max(model.R(s,:) + (model.gamma * P' * v)');
        policy(s,:) = action; 
                      
%         Cum_Rwd(iterations) = Cum_Rwd(iterations) + model.gamma * model.R(s, action);
    end   
    old_v = v;    
    v = v_;
    pi = policy;   
    if v - old_v <= threshold
        fprintf('Value function converged after %d iterations\n',iterations);
        break;
    end      
end


end
