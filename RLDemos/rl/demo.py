from __future__ import division

import numpy as np
import matplotlib.pyplot as pl

import discrete
import dp
import rl


def policy_evaluation(m=5, n=6, goal=8, gamma=0.7):
    # define the model.
    P = discrete.create_gridworld(m,n)
    R = np.zeros(m*n)
    R[goal] = 1

    # get the optimal policy.
    pi = dp.value_iteration(R, gamma, P)
    Ppi = dp.matrix_from_policy(P, pi)

    V = np.zeros(m*n)
    pl.clf()

    for i in xrange(100):
        pl.pcolor(V.reshape(n,m))
        pl.draw()
        raw_input()
        V = R + gamma * Ppi.dot(V)


def policy_iteration(m=5, n=6, goal=8, gamma=0.7):
    # define the model.
    P = discrete.create_gridworld(m,n)
    R = np.zeros(m*n)
    R[goal] = 1

    V = np.zeros(m*n)
    pl.clf()

    for i in xrange(100):
        pl.pcolor(V.reshape(n,m))
        pl.draw()
        raw_input()

        Q = dp.action_values(R, gamma, P, V)
        pi = np.argmax(Q, axis=1)
        V = dp.policy_evaluation(R, gamma, P, pi)


def value_iteration(m=5, n=6, goal=8, gamma=0.7):
    # define the model.
    P = discrete.create_gridworld(m,n)
    R = np.zeros(m*n)
    R[goal] = 1

    V = np.zeros(m*n)
    pl.clf()

    for i in xrange(100):
        pl.pcolor(V.reshape(n,m))
        pl.draw()
        raw_input()

        Q = dp.action_values(R, gamma, P, V)
        pi = np.argmax(Q, axis=1)
        Ppi = dp.matrix_from_policy(P, pi)
        V = R + gamma * Ppi.dot(V)


def td_policy_evaluation(m=5, n=6, goal=8, gamma=0.7, alpha=0.1):
    # define the model.
    P = discrete.create_gridworld(m,n)
    R = np.zeros(m*n)
    R[goal] = 1

    model = discrete.DiscreteMDP(P, R)
    nx = m*n
    na = 4

    pi = dp.value_iteration(model.R, gamma, model.P)
    V = np.zeros(m*n)
    pl.clf()

    for i in xrange(1000):
        if i % 10 == 0:
            pl.pcolor(V.reshape(n,m))
            pl.draw()
            raw_input()

        x = np.random.randint(nx)
        for t in xrange(10):
            r, x_ = model.sample_next(x, pi[x])
            V[x] = V[x] + alpha * (r + gamma*V[x_] - V[x])
            x = x_


def sarsa(m=5, n=6, goal=8, gamma=0.7, alpha=0.5, epsilon=0.5):
    # define the model.
    P = discrete.create_gridworld(m,n)
    R = np.zeros(m*n)
    R[goal] = 1

    model = discrete.DiscreteMDP(P, R)
    nx = m*n
    na = 4
    Q = 10 * np.ones((nx, na))

    for i in xrange(1000):
        if i % 10 == 0:
            pl.pcolor(np.max(Q, axis=1).reshape(n,m))
            pl.draw()
            raw_input()

        x = np.random.randint(nx)
        a = rl.epsilon_greedy(Q[x], epsilon)
        for t in xrange(10):
            r, x_ = model.sample_next(x, a)
            a_ = rl.epsilon_greedy(Q[x_], epsilon)
            Q[x,a] = Q[x,a] + alpha * (r + gamma * Q[x_,a_] - Q[x,a])
            x = x_
            a = a_

