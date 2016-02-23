clear all
clc

cliffworld;
episodes = 300;
iterations_every_episode = 300;
iterations = 50;


Result_Sarsa = zeros(episodes, iterations);
Result_q = zeros(episodes, iterations);


for iter = 1:iterations,
    [~, ~, Result_Sarsa(:,iter)] = sarsa(model, iterations_every_episode, episodes);
    [~, ~, Result_q(:,iter)] = qLearning(model, iterations_every_episode, episodes);
end

J_Sarsa = zeros(episodes,1);
J_q = zeros(episodes,1);
for i = 1:episodes,
    J_Sarsa(i) = mean(Result_Sarsa(i,:));
    J_q(i) = mean(Result_q(i,:));
end

plot([1:episodes], J_Sarsa')
hold on
plot([1:episodes], J_q','r')



figure(1)
plot([1:episodes], J_Sarsa', 'k' ,[1:episodes], J_q', 'r')
legend('Sarsa', 'Q-Learning')
xlabel('Number of Episodes','fontweight','bold','fontsize',12)
ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);


% cliffworld;
% episodes = 100;
% [~, ~, J_Q] = qLearning2(model, 100, episodes)
% plot([1:episodes], J_Q')
% 
% 





% 
% figure(1)
% plot([1:episodes], J_Sarsa', 'k' ,[1:episodes], J_Q, 'r')
% legend('Sarsa', 'Q-Learning')
% xlabel('Number of Episodes','fontweight','bold','fontsize',12)
% ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
% title('Q-Learning and SARSA on Cliff World MDP','fontweight','bold','fontsize',12);