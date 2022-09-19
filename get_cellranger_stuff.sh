
# This script contains various download commands for acquiring genomes, and sample index files from the 10x website.

GENOMEDIR=/scratch/tandrew6/Genomes/Human/

cd $GENOMEDIR

# cellranger human - July 7 2020
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
mv refdata-gex-GRCh38-2020-A.tar.gz cellranger_human_refdata-gex-GRCh38-2020-A.tar.gz
tar -xvzf cellranger_human_refdata-gex-GRCh38-2020-A.tar.gz

# cellranger mouse - July 7 2020
#wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-mm10-2020-A.tar.gz
#tar -xvzf refdata-gex-mm10-2020-A.tar.gz

# cellranger human+ mouse - July 7 2020
#wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-and-mm10-2020-A.tar.gz
#tar -xvzf refdata-gex-GRCh38-and-mm10-2020-A.tar.gz

# Sample Index sets:
# Chromium Single Cell 3' v2
#wget https://cf.10xgenomics.com/supp/cell-exp/chromium-shared-sample-indexes-plate.csv
#mv chromium-shared-sample-indexes-plate.csv chromium-shared-sample-indexes-plate-3v2.csv
# Chromium Single Cell 3' v1
#wget https://cf.10xgenomics.com/supp/cell-exp/chromium-single-cell-sample-indexes-plate-v1.csv
#mv chromium-single-cell-sample-indexes-plate-v1.csv chromium-single-cell-sample-indexes-plate-3v1.csv
# Chromium Single Cell 3' v1
#wget https://cf.10xgenomics.com/supp/cell-exp/gemcode-single-cell-sample-indexes-plate.csv
#mv gemcode-single-cell-sample-indexes-plate.csv gemcode-single-cell-sample-indexes-plate_3pr.csv

