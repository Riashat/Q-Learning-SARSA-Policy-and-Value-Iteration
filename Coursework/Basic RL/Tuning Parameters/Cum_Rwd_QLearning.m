cliffworld;
episodes = 100;
[~, ~, J] = qLearning(model, 1000, episodes)
plot([1:episodes], J')


smallworld;
episodes = 100;
[~, ~, J] = qLearning(model, 1000, episodes)
plot([1:episodes], J')
