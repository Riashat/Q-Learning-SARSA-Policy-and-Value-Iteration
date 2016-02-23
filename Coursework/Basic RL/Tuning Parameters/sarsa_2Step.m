function [v, pi, J] = sarsa_2Step(model, maxit, maxeps)

% initialize the value function
Q = zeros(model.stateCount, 4);  
pi = ones(model.stateCount, 1);  
alpha = 0.2;
policy = ones(model.stateCount, 1);
Cum_Rwd = zeros(length(maxeps), 1);
for i = 1:maxeps,
    %every time we reset the episode, start at the given startState   
    %get Start State
    s = model.startState;
    a = epsilon_greedy_policy(Q(s,:));
    
    Rwd = 0;
   
    for j = 1:maxit,    %FOR EACH STEP OF EPISODE
        
        p = 0;
        p_2=0;
        r = rand;
        r_q = rand;
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
        %CHOOSE A' FROM S' USING GREEDY POLICY
        a_ = epsilon_greedy_policy(Q(s_,:));
        
        
        % 2nd step of SARSA
        for two_step_state = 1:model.stateCount,
            p_2 = p_2 + model.P(s_, two_step_state, a_);
            if r_q <= p_2,
                break;
            end
        end
        
        s_2 = two_step_state;
        reward_2 = model.R(s_2,a_);
        a_2 = epsilon_greedy_policy(Q(s_2,:));
        
        Rwd = Rwd + reward + reward_2;
               
        % IMPLEMENT THE UPDATE RULE FOR Q HERE.
        Q(s,a) = Q(s,a) + alpha * [reward + model.gamma* reward_2 + model.gamma.^2 * Q(s_2, a_2) - Q(s,a)];
        
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


