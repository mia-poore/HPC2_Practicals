# conda-hpc-snakemake-example

## Notes from meeting

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
-------------------------------

## Practical instructions

The pipeline in this repository analyses data collected from online reviews of prescribed medications.

Specifically, it:
1. Identifies the 4 most common conditions experienced by people writing reviews
2. Finds words and bigrams used when describing the side effects of medications prescribed for each condition
3. Plots wordclouds to visualise the most common words and bigrams used to describe the side effects associated with medications prescribed for each condition

### 1. Setting up Git and Conda on HPC

#### Git
1. Log into bc4
2. Add git module
3. Setup ssh access for git
4. Fork this repository
5. Clone forked repository to **home??** partition
   
#### Conda / Mamba
1. Follow ACRC's instructions to install mamba on your work partition
2. Navigate to cloned repository ad create a conda environment from environment.yml
3. Activate the conda environment

### 2. Run the analysis on HPC
1. Look at `run_analysis.sh`: this is a sumbission script to run the pipeline on BlueCrystal. It does not make use of Snakemake.
    i. Add comments to the submission script, describing what each step does
    ii. Submit the submission script to the jobque
    iii. Add, commit and push the results to git so that you can view the figures locally
2. Look at `Snakefile`: this is a snakemake pipeline for the analysis.
    i. Compare this to the commands in `run_analysis.sh`. What commands aren't executed by the Snakefile?
    ii. Execute the Snakefile with a dry run (`snakemake -n`) -- what error do you see?
    iii. *something about using setup/make_config.sh to create config. Could we make it so that it doesn't run / there is an error they need to fix?*
3. ** final step to run snakemake pipeline on HPC -- need submission script for snakemake? **

---------------------------------------- 

## Notes from meeting continued

8. try running scripts / snakemake without submitting
9. try submitting snakemake to hpc - look at previous hpc submission scripts and try to fix the parameters for snakemake. Note if you're making changes, consider raising an Issue in your forked github repository, creating a new branch, checking out that new branch and committing and pushing the changes there, then making a pull request.
10. try submitting in tmux for longer running jobs
11. Update the README.md to explain how to run your pipeline in different environments.

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
  
  




















