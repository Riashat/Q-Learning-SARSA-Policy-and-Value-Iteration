from __future__ import division
import numpy as np


__all__ = ['matrix_from_policy', 'action_values',
           'policy_evaluation', 'policy_iteration', 'value_iteration']


def matrix_from_policy(P, pi):
    """
    Given an array of transition probabilities of the form P[a,x,x_],
    create a transition probability matrix from policy pi.
    """
    pi = np.asarray(pi, dtype=int)
    Ppi = np.zeros_like(P[0])
    for i in xrange(Ppi.shape[0]):
        Ppi[i] = P[pi[i], i]
    return Ppi


def action_values(R, gamma, P, V):
    """
    Compute the Q function, given the reward, discount factor,
    transition model, and the value function V.
    """
    na, nx = P.shape[0], P.shape[1]
    Q = np.zeros((nx, na))
    for a in xrange(na):
        Q[:,a] = R + gamma * P[a].dot(V)
    return Q


def policy_evaluation(R, gamma, P, pi, V=None):
    V = np.zeros(P.shape[1]) if (V is None) else V
    Ppi = matrix_from_policy(P, pi)
    delta = np.inf

    while delta > 1e-10:
        Vold = V
        V = R + gamma * Ppi.dot(V)
        delta = np.max(np.abs(Vold - V))

    return V


def policy_iteration(R, gamma, P, V=None):
    V = np.zeros(P.shape[1]) if (V is None) else V
    delta = np.inf

    while delta > 1e-10:
        Q = action_values(R, gamma, P, V)
        pi = np.argmax(Q, axis=1)

        Vold = V
        V = policy_evaluation(R, gamma, P, pi, V)
        delta = np.max(np.abs(Vold - V))

    return pi


def value_iteration(R, gamma, P, V=None):
    V = np.zeros(P.shape[1]) if (V is None) else V
    delta = np.inf

    while delta > 1e-10:
        Q = action_values(R, gamma, P, V)
        pi = np.argmax(Q, axis=1)
        Ppi = matrix_from_policy(P, pi)

        Vold = V
        V = R + gamma * Ppi.dot(V)
        delta = np.max(np.abs(Vold - V))

    return pi

