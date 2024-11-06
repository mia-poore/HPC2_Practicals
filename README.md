# conda-hpc-snakemake-example

-------------------------------

## Practical instructions

The pipeline in this repository analyses data collected from online reviews of prescribed medications.

Specifically, it:
1. Identifies the 4 most common conditions experienced by people writing reviews
2. Finds words and bigrams used when describing the side effects of medications prescribed for each condition
3. Plots wordclouds to visualise the most common words and bigrams used to describe the side effects associated with these medications

## Practical 1: Conda on HPC

### Setting up Git and Conda

#### Git
1. Log into bc4
2. Add git module
3. Setup ssh access for git
4. Fork this repository
5. Clone forked repository to **home??** partition
   
#### Conda / Mamba
1. Follow ACRC's instructions to install mamba on your work partition
2. Navigate to cloned repository and create a conda environment from environment.yml
3. Activate the conda environment

### Run analysis using a conda environment

Look at `practical_1/run_analysis.sh`: this is a sumbission script to run the pipeline on BlueCrystal. It does not make use of Snakemake.

1. Add comments to the submission script, describing what each step does
2. Submit the submission script to the jobque
3. Add, commit and push the results to git so that you can view the figures locally
4. **extension** Edit the submission script to run as an array job

## Practical 2: Snakemake on HPC

You will now re-run the analysis using Snakemake. First, navigate to the root directory and clear all derived data and results:

`rm -r ./results/`
`rm -r ./data/derived/`

### Convert the bash pipeline to snakemake

Look at `practical_2/Snakefile`: this is a snakemake pipeline for the analysis.
1. Compare this to the commands in `run_analysis.sh`. What commands aren't executed by the Snakefile?
2. Execute snakemake with a dry run (`snakemake -n`) -- what error(s) do you see?
3. *something about using setup/make_config.sh to create config. Could we make it so that it doesn't run / there is an error they need to fix?*
4. Execute snakemake with a dry run again -- are all errors fixed? When ready, run on login node as a single job (`snakemake -j1`)

### Submit snakemake to the job queue

Look at the submission scripts from practical 1. Try to adapt them for snakemake. Hint: `srun` 
**...**

## Things to consider

If you're making changes, consider raising an Issue in your forked github repository, creating a new branch, checking out that new branch and committing and pushing the changes there, then making a pull request.

Update the README.md to explain how to run your pipeline in different environments.

## Extensions

1. try submitting in tmux for longer running jobs
2. **....**
---------------------------------------- 

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

## Formative

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
  
  




















