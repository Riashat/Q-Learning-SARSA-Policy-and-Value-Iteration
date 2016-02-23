function [v, pi, J] = sarsa(model, maxit, maxeps, epsilon, alpha)

% initialize the value function
Q = zeros(model.stateCount, 4);  
pi = ones(model.stateCount, 1);  

policy = ones(model.stateCount, 1);

Cum_Rwd = zeros(length(maxeps), 1);

for i = 1:maxeps,
    %every time we reset the episode, start at the given startState   
    %get Start State
    s = model.startState;
    
    %OR INITIALIZE ACTION ARBITRARILY
    %a = 1;
    % initialize the first action greedily as well
    a = epsilon_greedy_policy(Q(s,:), epsilon);
    
    Rwd = 0;
   
    for j = 1:maxit,    %FOR EACH STEP OF EPISODE
        
        % PICK AN ACTION
        %%a = 1;
        
        p = 0;
        r = rand;
               
       %      reward = -1;   
        %while (s ~= model.goalState)
        
        for next_state = 1:model.stateCount,
            p = p + model.P(s, next_state, a);
            if r <= p,
                break;
            end
        end
              
        %TAKE ACTION, OBSERVE S' AND R
        s_ = next_state;
        
        %get R with given a
        reward = model.R(s,a); 
        
        Rwd = Rwd + reward;
        
        %CHOOSE A' FROM S' USING GREEDY POLICY
        a_ = epsilon_greedy_policy(Q(s_,:), epsilon);
        
        % IMPLEMENT THE UPDATE RULE FOR Q HERE.
        Q(s,a) = Q(s,a) + alpha * [reward + model.gamma * Q(s_, a_) - Q(s,a)];
        
        s = s_;
        a = a_;

        [~, idx] = max(Q(s,:));
        policy(s) = idx;
        q = Q(:, idx);

         if s == model.goalState
            break;
         end
            
             
    end   
    Cum_Rwd (i)  = Rwd;
end

pi = policy;
v = q;

J = Cum_Rwd;

end


