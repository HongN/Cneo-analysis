
## repeat mask of the VNIa-5 genome
funannotate-docker mask -i crypto.fasta --cpus 4 -o MyAssembly.fa

## align RNA-seq data
funannotate-docker train -i MyAssembly.fa -o fun --left CH46_R1_1.fastq.gz CH46_R2_1.fastq.gz CH46_R3_1.fastq.gz --right CH46_R1_2.fastq.gz CH46_R2_2.fastq.gz CH46_R3_2.fastq.gz --stranded RF --jaccard_clip --species "Cryptococcus neoformans" --strain VNIa-5_BK42 --cpus 8

## gene prediction
funannotate-docker predict -i MyAssembly.fa -o fun --species "Cryptococcus neoformans" --strain VNIa-5_BK42 --cpus 8

## add UTR data
funannotate-docker update -i fun --cpus 8

##interproscan functional annotation; protein file was generated in "funannotate update" step
/home/minc/biosoft/interproscan-5.72-103.0/interproscan.sh -i VNIa-5_BK42.proteins.fa -f xml -cpu 8

##incorporate interpro functional annotation data
funannotate-docker annotate -i fun --iprscan VNIa-5_BK42.proteins.fa.xml --cpus 8

