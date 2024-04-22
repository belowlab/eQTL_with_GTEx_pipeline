# From GTEx RNAseq pipeline
tpm_gct=/vgipiper04/CCHC/RNAseq/batch1_2_3_4/GTEx/expression/CCHC_batch1_2_3_4.rnaseq_tpm.low_quality_dropped.gct.gz
counts_gct=/vgipiper04/CCHC/RNAseq/batch1_2_3_4/GTEx/expression/CCHC_batch1_2_3_4.rnaseq_count.low_quality_dropped.gct.gz
# annotation_gtf=/data100t1/home/wanying/CCHC/RNAseq_gtex_pipeline/GTEx_ref/gencode.v44.basic.collapsed.gtf.gz
annotation_gtf=/data100t1/home/wanying/CCHC/RNAseq_gtex_pipeline/GTEx_ref/gencode.v26.collapsed.gtf.gz

# TSV linking sample IDs (columns in expression matrices) to participant IDs (VCF IDs), without header
sample_participant_lookup=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/supporting_files/sample_participant_id_mapping.tsv

# tpm_gct=/data/supporting_files/CCHC_batch1_2_3_4.rnaseq_tpm.low_quality_dropped.gct.gz
# counts_gct=/data/supporting_files/CCHC_batch1_2_3_4.rnaseq_count.low_quality_dropped.gct.gz
# annotation_gtf=/data/supporting_files/gencode.v44.basic.collapsed.gtf.gz

# # TSV linking sample IDs (columns in expression matrices) to participant IDs (VCF IDs), without header
# sample_participant_lookup=/data/supporting_files/sample_participant_id_mapping.tsv

prefix=CCHC_batch1_2_3_4_TMM.low_quality_dropped
# vcf_chr_list not used any more
code_path=/data100t1/home/wanying/lab_code/gtex-pipeline/qtl/src
# code_path=/src

python3 ${code_path}/eqtl_prepare_expression.py ${tpm_gct} ${counts_gct} ${annotation_gtf} \
    ${sample_participant_lookup} ${prefix} \
    --tpm_threshold 0.1 \
    --count_threshold 6 \
    --sample_frac_threshold 0.2 \
    --normalization_method tmm

