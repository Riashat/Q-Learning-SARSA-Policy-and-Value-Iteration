function [v, pi] = policyIteration2(model, maxit)

% initialize the value function
v = zeros(model.stateCount, 1);
pi = ones(model.stateCount, 1);
% old_v = zeros(model.stateCount, 1);
policy = ones(model.stateCount, 1);
tol = 0.0000000000000000000001;
updates = 1000;
old_v = zeros(model.stateCount, 1);

for iterations = 1:maxit,
     
    for i = 1:updates
    
         v_ = zeros(model.stateCount, 1);
        
        % perform the Bellman update for each state
        for s = 1:model.stateCount
            v_(s) = model.R(s, policy(s)) + (model.gamma * model.P(s, :, policy(s)) * v)';
        end
        
    old_v = v;
    v = v_;
    
    if v - old_v <= tol
        fprintf('Value function converged after %d iterations\n',updates);
        break;
    end      

     

    
    end
    
    
    for s = 1:model.stateCount
    
        P = reshape(model.P(s,:,:), model.stateCount, 4);    
        [~, action] = max ( model.R(s,:) + (model.gamma  * P' * v)' );
        policy(s) = action;

    end
   
    %%% OR USE A BREAK TO CHECK
    % IF THE OLD POLICY IS SAME AS NEW POLICY?

    
end

pi = policy;
v = v_;

end



