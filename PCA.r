## VCF file to phylip file (alignment)
 ~/biosoft/tasseladmin-tassel-5-standalone-bd304d03e096/run_pipeline.pl -Xmx32g -fork1 -vcf combined.vcf -export crypto_snp -exportType Phylip_Inter -sortPositions -runfork1

setwd("C:/Users/nan/Desktop/Fisher_cryptococcus/EV/result summarized/EV_tree_PCA/PCA")

##read inalignment
library(seqinr)
nh<- read.alignment(file="crypto_snp.phy",format="phylip")

##perform PCA analysis using adegenet
library(adegenet)
x <- alignment2genind(nh)
pca1 <- dudi.pca(x, center=TRUE,scale=FALSE,scannf=FALSE, nf=2)
write.csv(pca1$li,file="snf1_pca.csv")
write.csv(pca1$eig,file="snf1_pca_eig.csv")
