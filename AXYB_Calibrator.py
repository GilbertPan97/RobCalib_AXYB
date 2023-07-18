epsilon_safemargin = 1e-6
epsilon_sdptol = 1e-7

from sympy import init_printing
init_printing()

import os
import pickle
import sympy
import numpy
import time
import lmi_sdp

from lmi_sdp import init_lmi_latex_printing
init_lmi_latex_printing()


n_beta = 24
beta_symbs = sympy.Matrix([sympy.Symbol('beta'+str(i+1),real=True) for i in range(n_beta)])


from support_funcs.utils import skew, mrepl
from lmi_sdp import LMI_PD, LMI
from sympy import BlockMatrix, Matrix, eye, Identity

I = Identity
S = skew


import scipy.io as sio
import numpy as np
from lmi_sdp import LMI_NSD
dataPath = 'M_Code/tmp_Data/'
datafileName = 'calibInput.mat'
data = sio.loadmat(dataPath+datafileName)


rho1_ols = np.asmatrix(data['rho1'])
rho2_ols = np.asmatrix(data['rho2'])
R1_ols = np.asmatrix(data['R1'])
rho2_norm_sqr_wls = np.linalg.norm(rho2_ols)**2

u = sympy.Symbol('u')
U_rho = BlockMatrix([[Matrix([u - rho2_norm_sqr_wls]),   (R1_ols*beta_symbs - rho1_ols).T],
                             [R1_ols*beta_symbs - rho1_ols,                     I(n_beta)]])
U_rho = U_rho.as_explicit()

lmis_fbpe_ols = [LMI(U_rho)]

variables_fbpe_ols = [u] + list(beta_symbs)


objf_fbpe_ols = u

from cvxopt import solvers
from lmi_sdp import to_cvxopt

# sol_fbpe_ols = solve_sdp(objf_fbpe_ols, lmis_fbpe_ols, variables_fbpe_ols)
c, Gs, hs = to_cvxopt(objf_fbpe_ols, lmis_fbpe_ols, variables_fbpe_ols)
sol = solvers.sdp(c, Gs=Gs, hs=hs)

beta = np.matrix(sol['x'])
error = beta[0]
Rx = beta[1:10].reshape(3,3)
tx = beta[19:22]
Ry = beta[10:19].reshape(3,3)
ty = beta[22:25]

HTMx = np.vstack((np.hstack((Rx,tx)), np.matrix([0, 0, 0, 1])))
HTMy = np.vstack((np.hstack((Ry,ty)), np.matrix([0, 0, 0, 1])))

sio.savemat(dataPath+'solution.mat', {'err':error, 'Hx': HTMx, 'Hy': HTMy})
