function action = greedy_policy(Q, maxit)

all_actions = [1 2 3 4];

epsilon = 1/maxit;     %find better way to choose epsilon

probability = rand();
    
    if probability < (epsilon/length(all_actions) + 1 - epsilon)
        [~, action] = max(Q);
        
    elseif probability > epsion/length(all_actions)
        action = all_actions(randi(length(all_actions)));
        
    end
    
    
end
    