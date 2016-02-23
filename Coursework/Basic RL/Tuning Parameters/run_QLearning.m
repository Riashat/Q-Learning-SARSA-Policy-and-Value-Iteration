smallworld;
[v, pi, ~] = qLearning(model, 100, 100)

plotVP(v,pi, paramSet)
title('Q Learning on Small World MDP, 100 Episodes, 100 Steps in Episode','fontweight','bold','fontsize',12);



gridworld;
[v, pi, ~] = qLearning(model, 300, 200)

plotVP(v,pi, paramSet)
title('Q Learning on Grid World MDP, 200 Episodes, 300 Steps in Episode','fontweight','bold','fontsize',12);





