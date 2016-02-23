smallworld;
[v, pi] = valueIteration(model, 1000)
plotVP(v,pi, paramSet)
title('Value Iteration on Small World MDP, 1000 Iterations','fontweight','bold','fontsize',12);



gridworld;
[v, pi] = valueIteration(model, 1000)
plotVP(v,pi, paramSet)
title('Value Iteration on Grid World MDP, 1000 Iterations','fontweight','bold','fontsize',12);


% cliffworld;
% [v, pi] = valueIteration(model, 100)
% 
% plotVP(v,pi, paramSet)
