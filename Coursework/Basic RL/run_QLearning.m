smallworld;
[v, pi, ~] = qLearning(model, 1000, 1000)

plotVP(v,pi, paramSet)
title('Q Learning on Small World MDP, 1000 Episodes, 1000 Steps in Episode','fontweight','bold','fontsize',12);



gridworld;
[v, pi, ~] = qLearning(model, 300, 200)

plotVP(v,pi, paramSet)
title('Q Learning on Grid World MDP, 200 Episodes, 300 Steps in Episode','fontweight','bold','fontsize',12);




%% TRY 2

