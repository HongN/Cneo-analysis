## FST  calculation
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --weir-fst-pop VNIa-5.txt --weir-fst-pop VNIa-31.txt --fst-window-size 10000 --fst-window-step 10000 --out Fst_5_31

## Pi calculation of VNIa-5 population
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --keep VNIa-5.txt --window-pi 10000 --out Pi_VNIa5
## Pi calculation of VNIa-31 population
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --keep VNIa-31.txt --window-pi 10000 --out Pi_VNIa31
