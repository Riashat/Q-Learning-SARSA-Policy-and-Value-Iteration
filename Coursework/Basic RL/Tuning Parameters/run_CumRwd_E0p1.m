clear all
clc

episodes = 500;
iterations_every_episode = 500;
iterations = 100;


epsilon = 0.1;
alpha = [0.1, 0.2, 0.4, 0.6, 0.9 ];


Result_Sarsa_Alpha = zeros(episodes, size(alpha,2));
Result_QLearning_Alpha = zeros(episodes, size(alpha,2));

Result_Sarsa = zeros(episodes, iterations);
Result_q = zeros(episodes, iterations);


for i = 1:size(epsilon, 2)
    
    for j = 1:size(alpha,2)

        
        for iter = 1:iterations,
            cliffworld;
            [~, ~, Result_Sarsa(:,iter)] = sarsa(model, iterations_every_episode, episodes, epsilon(i), alpha(j));
            [~, ~, Result_q(:,iter)] = qLearning(model, iterations_every_episode, episodes, epsilon(i), alpha(j));
        end

        
        J_Sarsa = zeros(episodes,1);
        J_q = zeros(episodes,1);
        
        
        
        for k = 1:episodes,
            J_Sarsa(k) = mean(Result_Sarsa(k,:));
            J_q(k) = mean(Result_q(k,:));
        end
        
        
        
        Result_Sarsa_Alpha(: , j) = J_Sarsa';
        Result_QLearning_Alpha (:, j) = J_q';
    
    end
    

    
end


figure(1)
plot([1:episodes], Result_Sarsa_Alpha(:,1), 'k' ,[1:episodes], Result_Sarsa_Alpha(:,2), 'r', [1:episodes], Result_Sarsa_Alpha(:,3), 'b', [1:episodes], Result_Sarsa_Alpha(:,4), 'm', [1:episodes], Result_Sarsa_Alpha(:,5), 'c')
legend('Alpha = 0.1', 'Alpha = 0.2', 'Alpha = 0.4', 'Alpha= 0.6', 'Alpha = 0.9' )
xlabel('Number of Episodes','fontweight','bold','fontsize',12)
ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
title('SARSA with Different Step Sizes on Cliffworld, Epsilon = 0.1','fontweight','bold','fontsize',12);


figure(2)
plot([1:episodes], Result_QLearning_Alpha(:,1), 'k' ,[1:episodes], Result_QLearning_Alpha(:,2), 'r', [1:episodes], Result_QLearning_Alpha(:,3), 'b', [1:episodes], Result_QLearning_Alpha(:,4), 'm', [1:episodes], Result_QLearning_Alpha(:,5), 'c')
legend('Alpha = 0.1', 'Alpha = 0.2', 'Alpha = 0.4', 'Alpha= 0.6', 'Alpha = 0.9' )
xlabel('Number of Episodes','fontweight','bold','fontsize',12)
ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
title('Q-Learning with Different Step Sizes on Cliffworld, Epsilon = 0.1','fontweight','bold','fontsize',12);


% 
% 
% figure(3)
% plot([1:episodes], Result_Sarsa_Alpha(:,1), 'k' ,[1:episodes], Result_QLearning_Alpha(:,1), 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);
% 
% 
% figure(4)
% plot([1:episodes], Result_Sarsa_Alpha(:,2), 'k' ,[1:episodes], Result_QLearning_Alpha(:,2), 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);
% 
% 
% 
% figure(5)
% plot([1:episodes], Result_Sarsa_Alpha(:,3), 'k' ,[1:episodes], Result_QLearning_Alpha(:,3), 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);
% 
% 
% figure(6)
% plot([1:episodes], Result_Sarsa_Alpha(:,4), 'k' ,[1:episodes], Result_QLearning_Alpha(:,4), 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);
% 
% 
% figure(7)
% plot([1:episodes], Result_Sarsa_Alpha(:,5), 'k' ,[1:episodes], Result_QLearning_Alpha(:,5), 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);
