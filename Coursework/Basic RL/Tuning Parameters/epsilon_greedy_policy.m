function action = epsilon_greedy_policy(Q, epsilon)

all_actions = [1 2 3 4];



% TRY DIFFERENT EPSILON AND ALPHA PARAMETERS


probability = rand();
    
    if probability < (1 - epsilon)
        [~, action] = max(Q);
        
    else
        action = all_actions(randi(length(all_actions)));
        
    end
    
    
end
    