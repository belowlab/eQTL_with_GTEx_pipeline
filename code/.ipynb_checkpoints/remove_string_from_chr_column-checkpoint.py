'''
Remove the 'chr' string from the chromosome column, then bgzip and tabix. Eg. change 'chr20' to '20'
Expects input file to be in BED format, such as the TMM expresion file from the GTEx RNAseq pipeline.
Details about the BED format: https://genome.ucsc.edu/FAQ/FAQformat.html#format1

Example call:
# Overwrite existing file
python remove_string_from_chr_column.py -i input.bed.gz -o output.bed --overwrite

# If do not want to overwrite existing file
python remove_string_from_chr_column.py -i input.bed.gz -o output.bed

# Code used in Wanying's eQTL mapping
code_path=/data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/code
for chr in {1..22}
    do
        python ${code_path}/remove_string_from_chr_column.py \
        -i /data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/input/CCHC_batch1_2_3_4_TMM.chr${chr}.bed.gz \
        -o /data100t1/home/wanying/CCHC/eQTL_gtex_pipeline/input/chr_col_fixed_tmm/CCHC_batch1_2_3_4_TMM.chr${chr}.chr_fixed.bed
    done
'''

import pandas as pd
import argparse
import os
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument('--input', '-i', type=str, help='Input BED file name')
parser.add_argument('--output', '-o', type=str, help='Output BED file name')
parser.add_argument('--chr_col', type=str, default='#chr',
                    help="Name of the chromosome column. '#chr' is the default columnn name used by GTEx pipeline")
parser.add_argument('--index', action='store_false', help='bgzip and tabix if true')
parser.add_argument('--overwrite', action='store_true', help='Overwrite existing file if true')
args = parser.parse_args()
print('# Arguments used:')
for arg in vars(args):
    print(f'# - {arg}:', getattr(args, arg))

if args.index: target_fn = args.output+'.gz' # Target file name, check if exist for overwriting option
else: target_fn = args.output
if os.path.isfile(target_fn) and not args.overwrite:
    print('# Output file exists, skip saving.')
    print('# DONE\n')
    exit()

if args.input.endswith('gz'):
    df = pd.read_csv(args.input, sep='\t', compression='gzip')
else:
    df = pd.read_csv(args.input, sep='\t', compression='gzip')

df[args.chr_col] = df[args.chr_col].apply(lambda x: x.lower().split('chr')[-1])
df.to_csv(args.output, sep='\t', index=False)

if args.index:
    cmd = f'bgzip {args.output}; tabix {args.output}.gz'
    subprocess.run(cmd, shell=True, check=True)
print('# DONE\n')