from __future__ import division
import numpy as np

__all__ = ['create_gridworld', 'DiscreteMDP']


def create_gridworld(m, n):
    """
    Create an m-by-n gridworld as a 3-array P of the form P[a,x,x_].
    """
    P = np.zeros((4, m*n, m*n))
    for i in xrange(m*n):
        if i < (n-1)*m: P[0, i, i+m] = 1
        if i%m < m-1: P[1, i, i+1] = 1
        if i >= m: P[2, i, i-m] = 1
        if i%m > 0: P[3, i, i-1] = 1

        for a in xrange(4):
            if P[a, i].sum() == 0:
                P[a, i, i] = 1
    return P


class DiscreteMDP(object):
    def __init__(self, P, R):
        self.P = np.array(P, ndmin=3)
        self.R = np.array(R)

        assert self.P.shape[1] == self.P.shape[2]
        assert self.R.size == self.P.shape[-1]

    def sample_next(self, x, a):
        x = int(x)
        a = int(a)

        r = self.R[x]
        x_ = np.nonzero(np.random.rand() < self.P[a,x].cumsum())[0][0]
        return r, x_

