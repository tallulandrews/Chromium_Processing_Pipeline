args <- commandArgs(trailingOnly=TRUE)

cellranger_outs_dir <- args[1]

require(Matrix)

mat <- Seurat::Read10X(paste(cellranger_outs_dir, "raw_feature_bc_matrix", sep="/"))

keep_threshold = args[2]
if (is.null(keep_threshold)) {
	keep_threshold=100
}

barcodes <- colnames(mat[,colSums(mat) > keep_threshold])

write.table(barcodes, quote=FALSE, row.names=F, col.names=F, file=paste(cellranger_outs_dir,"filtered_feature_bc_matrix", "velocyto_barcodes.tsv", sep="/"))


