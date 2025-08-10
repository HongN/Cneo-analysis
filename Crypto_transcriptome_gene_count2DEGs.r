setwd("C:/Users/nan/Desktop/Cneo/transcriptome")

## The ¡°htseq_count.csv¡± contained 7 columns: gene names; gene count result of VNIa-5 and VNIa-31 strain with 3 repeating respectively calculated by Htseq
targets <- read.csv('htseq_count.csv', row.names = 1, check.names = FALSE)

## control: VNIa-31; treat: VNIa-5
group <- rep(c('control', 'treat'), each = 3)

## standardize gene count data
library(edgeR)
dgelist <- DGEList(counts = targets[,1:6], group = group)
dgelist_norm <- calcNormFactors(dgelist, method = 'TMM')
design <- model.matrix(~group)
dge <- estimateDisp(dgelist_norm, design, robust = TRUE)
fit <- glmFit(dge, design, robust = TRUE)
lrt <- topTags(glmLRT(fit), n = nrow(dgelist$counts))
write.table(lrt, 'VNIa5_edgeR_rawdata.txt', sep = '\t', col.names = NA, quote = FALSE)

## identify DEGs
gene_diff <- read.delim('VNIa5_edgeR_rawdata.txt', row.names = 1, sep = '\t', check.names = FALSE)

gene_diff <- gene_diff[order(gene_diff$FDR, gene_diff$logFC, decreasing = c(FALSE, TRUE)), ]
gene_diff[which(gene_diff$logFC >= 1 & gene_diff$FDR < 0.001),'sig'] <- 'up'
gene_diff[which(gene_diff$logFC <= -1 & gene_diff$FDR < 0.001),'sig'] <- 'down'
gene_diff[which(abs(gene_diff$logFC) <= 1 | gene_diff$FDR >= 0.001),'sig'] <- 'normal'
gene_diff_select <- subset(gene_diff, sig %in% c('up', 'down'))
write.table(gene_diff_select, file = 'VNIa5_dif.txt', sep = '\t', col.names = NA, quote = FALSE)
