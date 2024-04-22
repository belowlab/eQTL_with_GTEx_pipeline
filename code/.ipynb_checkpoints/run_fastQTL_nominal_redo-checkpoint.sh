# Example call to run fastQTL on chromosome 1 with 10 PEER factors
# bash run_fastQTL_nominal.sh 1 10
# Or
# for i in {1..22}; do bash run_fastQTL_nominal.sh 1 10; done

cd /data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/output/nominal_runs_redo_new_peer
chr=$1
n_peers=$2

path_script=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/code/fastqtl/python
expression=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/input/CCHC_batch1_2_3_4_TMM.chr${chr}.bed.gz
vcf=/vgipiper04/CCHC/TOPMed_postimpute_042022/chr${chr}.dose.vcf.gz
prefix=chr${chr}.${n_peers}_peers.nominal

covariates=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/supporting_files/combined_covariates_peers_from_different_runs/redo_combined_covar_sex_age_pc1-5.${n_peers}_peers.combined_covariates.txt

python ${path_script}/run_FastQTL_threaded.py ${vcf} ${expression} ${prefix} \
--covariates ${covariates} \
--window 1e6 \
--ma_sample_threshold 10 \
--maf_threshold 0.01 \
--chunks 10 \
--threads 10
