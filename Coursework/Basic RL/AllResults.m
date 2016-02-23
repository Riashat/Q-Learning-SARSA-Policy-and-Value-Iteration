clear all
clc
load('run_CumRwd.mat')

load('Sarsa_Extensions.mat')


episodes = 500;

plot([1:episodes], J_Sarsa,'k',[1:episodes], J_Sarsa_2Step ,'r',[1:episodes], J_Sarsa_Lambda,'b')
legend('Sarsa', '2-Step Sarsa', 'Sarsa (Lambda)')
xlabel('Number of Episodes','fontweight','bold','fontsize',12)
ylabel('Cumulative Reward','fontweight','bold','fontsize',12)
title('Comparison of Different Sarsa Algorithms','fontweight','bold','fontsize',12);