rule concatenate_fq:
	input:
		file1 = "/oak/stanford/scg/lab_dmonack/sruddle/super_shedder/RNA/raw/usftp21.novogene.com/raw_data/A*/*_1.fq.gz"
		file2 = "/oak/stanford/scg/lab_dmonack/sruddle/super_shedder/RNA/raw/usftp21.novogene.com/raw_data/A*/*_2.fq.gz"
	output:
		"/oak/stanford/scg/lab_dmonack/sruddle/bugs/A*_concat.fq.gz"
	shell:
	"""
 	cat {input.file1} {input.file2} > /oak/stanford/scg/lab_dmonack/sruddle/bugs/A*_concat.fq.gz

	"""
