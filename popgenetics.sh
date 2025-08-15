## Fst calculation
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --weir-fst-pop ST5.txt --weir-fst-pop VNIa_other.txt --fst-window-size 10000 --fst-window-step 10000 --out Fst_china_vietnam


##snpdensity calculation
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --SNPdensity 10000 --out VNIa5




~/crypto_data/snp/EV_all/gwas/china_vietnam

#拆分染色体 keep可以决定留哪些在
for((i=1;i<=14;i++));do vcftools --vcf combined.vcf --recode --recode-INFO-all --stdout --chr ${i} > chr${i}.vcf;done

#10kb计算Fst
for((i=1;i<=14;i++));do /home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf chr${i}.vcf --haploid --weir-fst-pop VNIa5.txt --weir-fst-pop VNIa31.txt --fst-window-size 10000 --fst-window-step 10000 --out fst_chr${i};done

#10kb滑窗计算tajimaD;vcftools用judy版本 加--haploid,用以处理单倍体数据
for((i=1;i<=14;i++));do /home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf chr${i}.vcf --haploid --TajimaD 10000 --out TajimaD_chr${i};done

#10kb滑窗计算pi值
for((i=1;i<=14;i++));do /home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf chr${i}.vcf --haploid --window-pi 10000 --out Pi_chr${i};done

##计算整个群体的pi值
/home/minc/biosoft/vcftools-master/vcftools/bin/vcftools --vcf combined.vcf --haploid --keep VNIa5.txt --window-pi 10000 --out Pi_VNIa5
sed -i '1d' Pi_VNIa31.sites.pi
#计算某列的平均数
cat Pi_VNIa31.sites.pi|awk ' {sum+=$3} END {print "Average = ", sum/NR}'

#sweed计算CLR grid将染色体分为229份
SweeD-P -name crypto_chr1 -input chr1.vcf -grid 229 -minsnps 10 -maf 0.05 -missing 0.1 -ploidy 1 -threads 4

awk -F"," '{print "SweeD-P -name crypto_chr"$1" -input chr"$1".vcf -grid "$2" -minsnps 10 -maf 0.05 -missing 0.1 -ploidy 1 -threads 4"}' crypto_chr_grid > 1.sh

##SweeD真正使用
cp ~/hongnan_shell/crypto_chr_grid .
awk -F"," '{print "SweeD-P -name crypto_chr"$1" -input chr"$1".vcf -grid "$2" -ploidy 1 -threads 4"}' crypto_chr_grid > 1.sh


##整理结果
sed -i '1,2d' SweeD_Report.crypto_chr*
for((i=1;i<=14;i++));do paste -d"\t" Pi_chr${i}.windowed.pi SweeD_Report.crypto_chr${i} TajimaD_chr${i}.Tajima.D  > all_chr${i}.txt;done
cat all_chr* > 1.txt





## %%是在$右边，相当于把右边都删掉，以，为分隔； ##就是删掉变量左边内容
#chr=${sample[$i]%%,*}
#grid=${sample[$i]##*,}




