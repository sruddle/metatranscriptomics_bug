#!/bin/bash
#
#SBATCH --job-name=humann3
#
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH -c 5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75G
#SBATCH -p batch
#SBATCH --account=dmonack
#SBATCH --out=humann3-%j.out
#SBATCH --error=humann3-%j.err

ml anaconda && source activate metatranscriptomics_bugs

cd /labs/dmonack/sruddle/bugs

humann --input /oak/stanford/scg/lab_dmonack/sruddle/super_shedder/RNA/raw/usftp21.novogene.com/raw_data/A20/A20_CKDL200161453-1a_HK3KHDSXY_L3_1.fq.gz \
--output /oak/stanford/scg/lab_dmonack/sruddle/bugs/A20
