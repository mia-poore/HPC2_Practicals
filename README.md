# conda-hpc-snakemake-example

Files needed:

- Snakefile
- script1.R
- script2.sh
- environment.yaml
- slurm_config.json
- data/input.csv

Modules needed

- mamba
- git

Additional points

- ssh keys
- .bashrc files
- file permissions


Your tasks for this practical

1. get into bc4
2. add git module
3. Fork this repository
4. clone forked repository
5. add mamba module
6. create conda/mamba environment
7. try running scripts / snakemake without submitting
8. try submitting snakemake to hpc - look at previous hpc submission scripts and try to fix the parameters for snakemake. Note if you're making changes, consider raising an Issue in your forked github repository, creating a new branch, checking out that new branch and committing and pushing the changes there, then making a pull request.
9. try submitting in tmux for longer running jobs
10. Update the README.md to explain how to run your pipeline in different environments.

Formative

1. Migrate current pipeline to run on HPC
2. Can you parallelise the processing of the input files in a HPC batch array in this new pipeline configuration? Think about strategy here. How could `pre-pipeline-batching.R` help?


file1.txt
file2.txt
..
file2000.txt


In R:

batch1.txt:
  file1.txt
  file2.txt

batch2.txt:
  file3.txt
  file4.txt



Snakefile using pre-batch

rule: process_1
  input: "batch{batch}.txt"
  output:
    "processed{batch}.txt"
  script:
    something.r
  conda:
    

rule: aggregate
  input: expand("processed{batch}.txt", batch=range(1,100))
  output:
    "final.txt"
  script:
    "somethingelse.r"
  conda:
  
  


Snakefile using raw files

rule: process_1
  input: "file{sample}.txt"
  output:
    "processed{sample}.txt"
  script:
    something.r
  conda:
    

rule: aggregate
  input: expand("processed{sample}.txt", batch=range(1,100))
  output:
    "final.txt"
  script:
    "somethingelse.r"
  conda:
  
  




















