clear all
clc

cliffworld;
episodes = 500;
iterations_every_episode = 500;
iterations = 50;


Result_Sarsa_2step = zeros(episodes, iterations);
Result_Sarsa_Lambda = zeros(episodes, iterations);


for iter = 1:iterations,
    [~, ~, Result_Sarsa_2step(:,iter)] = sarsa_2Step(model, iterations_every_episode, episodes);
    [~, ~, Result_Sarsa_Lambda(:,iter)] = sarsa_lambda(model, iterations_every_episode, episodes);
end

J_Sarsa_2Step = zeros(episodes,1);
J_Sarsa_Lambda = zeros(episodes,1);
for i = 1:episodes,
    J_Sarsa_2Step(i) = mean(Result_Sarsa_2step(i,:));
    J_Sarsa_Lambda(i) = mean(Result_Sarsa_Lambda(i,:));
end

plot([1:episodes], J_Sarsa_2Step')
hold on
plot([1:episodes], J_Sarsa_Lambda','r')


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