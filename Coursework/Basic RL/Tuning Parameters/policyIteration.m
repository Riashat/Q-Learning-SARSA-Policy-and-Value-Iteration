function [v, pi] = policyIteration(model, maxit)

% initialize the value function
v = zeros(model.stateCount, 1);
pi = ones(model.stateCount, 1);
old_v = zeros(model.stateCount, 1);

for iterations = 1:maxit,
    % initialize the policy and the new value function
    policy = ones(model.stateCount, 1);
    v_ = zeros(model.stateCount, 1);
    
        % perform the Bellman update for each state
    for s = 1:model.stateCount,
        % COMPUTE THE VALUE FUNCTION AND POLICY
        % YOU CAN ALSO COMPUTE THE POLICY ONLY AT THE END
        P = reshape(model.P(s,:,:), model.stateCount, 4);
        
        [~, action] = max(model.R(s,:) + (model.gamma * P' * v)');
        
        v_(s,:) = model.R(s, action) + (model.gamma * P(:, action)' * v)' ; 
        
        policy(s,:) = action;
       
        
    end
    old_v = v; 
    v = v_;
    pi = policy;
    
       
    if v - old_v <= 0.0000000000000000000001
        fprintf('Value function converged after %d iterations\n',iterations);
        break;
    end   

end


end
