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

# Arugments: loomfile prefix
print("Arguments:", sys.argv)

#Load Loom file
vlm = vcy.VelocytoLoom(sys.argv[1])
prefix=str(sys.argv[2])

# extract each count matrix from the velocyto object
# convert it to ordinary inteters, then into a scipy-sparse matrix
# save the sparse matrix as an .mtx that is readable by the Matrix package into R
sio.mmwrite(prefix+"S_sparse_matrix.mtx", sparse.csr_matrix(np.int_(vlm.S)))
sio.mmwrite(prefix+"U_sparse_matrix.mtx", sparse.csr_matrix(np.int_(vlm.U)))
sio.mmwrite(prefix+"A_sparse_matrix.mtx", sparse.csr_matrix(np.int_(vlm.A)))
# Write the cellIDs and gene names to separate files.
np.savetxt(prefix+"cellIDs.tsv", vlm.ca.get("CellID"), delimiter="\t", fmt='%.100s')
np.savetxt(prefix+"geneNames.tsv", vlm.ra.get("Gene"), delimiter="\t", fmt='%.50s')

