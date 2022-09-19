args <- commandArgs(trailingOnly=TRUE) # directory of cellranger outs, threshold for number of UMI / barcode to keep a droplet.
if (length(args) < 1) {
	print "Usage: velocyto_refilter_cells.R [path to cellranger/outs directory] [minimum UMIs requires to keep a droplet for splice/unspliced quantification (default:100)]"
	exit(1)
}

cellranger_outs_dir <- args[1]

require(Matrix)

mat <- Seurat::Read10X(paste(cellranger_outs_dir, "raw_feature_bc_matrix", sep="/"))

# Implement default threshold
keep_threshold = args[2]
if (is.null(keep_threshold)) {
	keep_threshold=100
}

barcodes <- colnames(mat[,colSums(mat) > keep_threshold])

# save this within the filtered folder.
write.table(barcodes, quote=FALSE, row.names=F, col.names=F, file=paste(cellranger_outs_dir,"filtered_feature_bc_matrix", "velocyto_barcodes.tsv", sep="/"))


