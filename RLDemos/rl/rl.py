from __future__ import division
import numpy as np


def epsilon_greedy(q, epsilon):
    na = q.size
    if np.random.rand() < epsilon:
        return np.random.randint(na)
    else:
        return np.argmax(q)


def policy_evaluation(model, gamma, pi, nx, na, alpha, N=100, H=100):
    V = np.zeros(nx)
    pi = np.array(pi, dtype=int)

    for i in xrange(N):
        x = np.random.randint(nx)
        for t in xrange(H):
            r, x_ = model.sample_next(x, pi[x])
            V[x] = V[x] + alpha * (r + gamma*V[x_] - V[x])
            x = x_
    return V


def sarsa(model, gamma, nx, na, alpha, epsilon, N=1000, H=100):
    Q = 10 * np.ones((nx, na))

    for i in xrange(N):
        x = np.random.randint(nx)
        for t in xrange(H):
            a = epsilon_greedy(Q[x], epsilon)
            r, x_ = model.sample_next(x, a)
            a_ = epsilon_greedy(Q[x_], epsilon)
            Q[x,a] = Q[x,a] + alpha * (r + gamma * Q[x_,a_] - Q[x,a])
            x = x_
            a = a_
    return Q


def qlearning(model, gamma, nx, na, alpha, epsilon, N=1000, H=100):
    Q = 10 * np.ones((nx, na))

    for i in xrange(N):
        x = np.random.randint(nx)
        for t in xrange(H):
            a = epsilon_greedy(Q[x], epsilon)
            r, x_ = model.sample_next(x, a)
            Q[x,a] = Q[x,a] + alpha * (r + gamma * max(Q[x_]) - Q[x,a])
            x = x_
    return Q


