"""
EXAMPLE RUN:

snakemake --snakefile workflow/Snakefile \
	 --printshellcmds \
	 --cores 100 \
	 --keep-going \
	 --use-conda \
	 --conda-prefix /oak/stanford/scg/lab_dmonack/sruddle/conda_envs \
	 --cluster-config config/smk_cluster.json \
	 --cluster "sbatch --mem={cluster.memory} --partition={cluster.partition} --time={cluster.time} --error={cluster.error} --output={cluster.output}"

"""

configfile: "config/parameters.json"

import pandas as pd

SAMPLES = pd.read_csv("config/rnaseq_ids_new.csv") \
	['fastq_1'] \
	.str.split(pat="/", expand=True) \
	[11].tolist()

ANALYSIS_DIR = configfile["wd"]

rule all:
    input:
        out = expand("/oak/stanford/scg/lab_dmonack/sruddle/bugs/{sample_id}_concat.fq.gz", sample_id=SAMPLES)

rule concatenate_fq:
    input:
        seq_directory = "/oak/stanford/scg/lab_dmonack/sruddle/super_shedder/RNA/raw/usftp21.novogene.com/raw_data/{sample_id}/"
    output:
        concatenated_fq = ANALYSIS_DIR + "{sample_id}_concat.fq.gz"
    shell:
        """

				file1=$(ls {input.seq_directory}{wildcards.sample_id}_*_1.fq.gz)
				file2=$(ls {input.seq_directory}{wildcards.sample_id}_*_2.fq.gz)
				cat $file1 $file2 > {output.out}

				"""

rule run_humann3:
    input:
        concatenated_fq = ANALYSIS_DIR + "{sample_id}_concat.fq.gz"
    output:
        chocophlan = ANALYSIS_DIR + "{sample_id}/{sample_id}/{sample_id}_combined_metaphlan_bugs_list.tsv"
    conda:
        "envs/humann3.yaml"
    shell:
        """

				humann \
					--input {input.concatenated_fq} \
					--output {ANALYSIS_DIR}

				"""
