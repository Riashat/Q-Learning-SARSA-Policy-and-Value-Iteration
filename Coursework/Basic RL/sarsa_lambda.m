function [v, pi, J] = sarsa_lambda(model, maxit, maxeps)

% initialize the value function
Q = zeros(model.stateCount, 4);  
pi = ones(model.stateCount, 1);  
alpha = 1;    lambda = 0.4;
policy = ones(model.stateCount, 1);

Cum_Rwd = zeros(length(maxeps), 1);

for i = 1:maxeps,
    eligibility = zeros(model.stateCount, 4);    
    s = model.startState;    
    a = epsilon_greedy_policy(Q(s,:), maxit);
    
    Rwd = 0;
   
    for j = 1:maxit,    %FOR EACH STEP OF EPISODE
        
        p = 0;
        r = rand;
               
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
        a_ = epsilon_greedy_policy(Q(s_,:), maxit);
        
        Delta = reward + (model.gamma * Q(s_, a_) - Q(s,a));
        
        eligibility(s,a) = eligibility(s,a) + 1;
        
        for m = 1:model.stateCount
            for n = 1:4
                Q(m,n) = Q(m,n) + alpha/maxit * Delta * eligibility(m,n);
                eligibility(m,n) = model.gamma * lambda * eligibility(m,n);
            end
        end
        
        
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


