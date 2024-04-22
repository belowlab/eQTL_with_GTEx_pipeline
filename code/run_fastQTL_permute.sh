# For this run --chunks must be <100 for chr22 (will get error due to no gene found in the chunk)
# Example call on chr1 with 60 peer factors:
# bash run_fastQTL_permute.sh 1 60
cd /data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/output/permute_runs
chr=$1
n_peers=$2

path_script=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/code/fastqtl/python
expression=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/input/CCHC_batch1_2_3_4_TMM.chr${chr}.bed.gz
vcf=/vgipiper04/CCHC/TOPMed_postimpute_042022/chr${chr}.dose.vcf.gz
prefix=chr${chr}.${n_peers}_peers.permute
covariates=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/supporting_files/combined_covariates_peers_from_different_runs/redo_combined_covar_sex_age_pc1-5.${n_peers}_peers.combined_covariates.txt

python ${path_script}/run_FastQTL_threaded.py ${vcf} ${expression} ${prefix} \
--covariates ${covariates} \
--permute 1000 10000 --window 1e6 \
--ma_sample_threshold 10 \
--maf_threshold 0.01 \
--chunks 10 \
--threads 10