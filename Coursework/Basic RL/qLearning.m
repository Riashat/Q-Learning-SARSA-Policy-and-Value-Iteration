function [v, pi, Cum_Rwd] = qLearning(model, maxit, maxeps)
% initialize the value function
Q = zeros(model.stateCount, 4);
pi = ones(model.stateCount, 1);  
policy = ones(model.stateCount, 1);
Cum_Rwd = zeros(maxeps, 1);

for i = 1:maxeps,
    % every time we reset the episode, start at the given startState
    s = model.startState; 
    a=1;

    for j = 1:maxit       %repeat for each step of episode
        p = 0;
        r = rand;

        for s_ = 1:model.stateCount,
            p = p + model.P(s, s_, a);
            if r <= p,
                break;
            end
        end                 
        %get action from behaviour policy - epsilon_greedy wrt Q(s,a)
        %action from behaviour policy
        a_ = epsilon_greedy_policy(Q(s, :), j);                        
        %take action, observe r 
        Reward = model.R(s,a);
        Cum_Rwd(i) = Cum_Rwd(i) + model.gamma * Reward;

        TargetQ = Reward + model.gamma * max(Q(s_, :));

        alpha = 1/j;
        Q(s,a) = Q(s,a) + alpha * ( TargetQ - Q(s,a) );
        
        s = s_;
        a = a_;
               
        [~, idx] = max(Q(s,:));
        policy(s,:) = idx;
        q = Q(:, idx);
                      
        % SHOULD WE BREAK OUT OF THE LOOP?              
         if s == model.goalState
             if Reward == model.R(model.goalState, a)
                break;
             end
         break;
         end
    end
end

pi = policy;
v = q;
end

