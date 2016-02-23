cliffworld;
episodes = 100;
iterations_every_episode = 100;
alpha = 0.2;
[~, ~, J] = sarsa(model, iterations_every_episode, episodes)
figure(1)
plot([1:episodes], J')


% gridworld;
% episodes = 100;
% 
% [~, ~, J] = sarsa(model, 100000, episodes)
%figure(2)
% plot([1:episodes], J')


smallworld;
episodes = 100;
[~, ~, J] = sarsa(model, 100, episodes)
figure (3)
plot([1:episodes], J')
