function action = epsilon_greedy_policy(Q, j)
all_actions = [1 2 3 4];
epsilon = 1/j;     %find better way to choose epsilon
probability = rand();
    
    if probability < (1 - epsilon)
        [~, action] = max(Q);        
    else
        action = all_actions(randi(length(all_actions)));       
    end    
end
    