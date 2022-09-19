import sys
import numpy as np
import pandas as pd 
import matplotlib
import matplotlib.pyplot as plt
import loompy
import velocyto as vcy
import scipy.sparse as sparse
import scipy.io as sio
import scipy.stats as stats

print("Arguments:", sys.argv)

vlm = vcy.VelocytoLoom(sys.argv[1])

sS = sparse.csr_matrix(np.int_(vlm.S))
prefix=str(sys.argv[2])

sio.mmwrite(prefix+"S_sparse_matrix.mtx", sS)
sio.mmwrite(prefix+"U_sparse_matrix.mtx", sparse.csr_matrix(np.int_(vlm.U)))
sio.mmwrite(prefix+"A_sparse_matrix.mtx", sparse.csr_matrix(np.int_(vlm.A)))
np.savetxt(prefix+"cellIDs.tsv", vlm.ca.get("CellID"), delimiter="\t", fmt='%.100s')
np.savetxt(prefix+"geneNames.tsv", vlm.ra.get("Gene"), delimiter="\t", fmt='%.50s')

