% getting errors due to the terminal state condition

smallworld;
[v, pi, ~] = sarsa(model, 100, 100);

plotVP(v,pi, paramSet)


gridworld;
[v, pi, ~] = sarsa(model, 300, 200);

plotVP(v,pi, paramSet)
title('SARSA on Grid World MDP, 200 Episodes, 300 Iterations','fontweight','bold','fontsize',12);





cliffworld;
[v, pi, ~] = sarsa(model, 300, 200);
plotVP(v,pi, paramSet)
title('SARSA on Cliff World MDP, 200 Episodes, 300 Iterations','fontweight','bold','fontsize',12);
