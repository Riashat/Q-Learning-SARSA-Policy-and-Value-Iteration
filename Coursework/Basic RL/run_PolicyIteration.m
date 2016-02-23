
% CORRECT
smallworld;
[v, pi] = policyIteration2(model, 1000)
plotVP(v,pi, paramSet)


% CORRECT
gridworld;
[v, pi] = policyIteration2(model, 1000)
plotVP(v,pi, paramSet)
title('Policy Iteration on Grid World MDP, 1000 Iterations','fontweight','bold','fontsize',12);





smallworld;
[v, pi] = policyIteration(model, 1000)

plotVP(v,pi, paramSet)

gridworld;
[v, pi] = policyIteration(model, 1000)

plotVP(v,pi, paramSet)
