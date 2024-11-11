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
5. Clone forked repository to home partition
   
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

### Adapt the bash pipeline to work with snakemake

Look at `practical_2/Snakefile`: this is a snakemake workflow for the analysis.
1. Compare this to the commands in `run_analysis.sh`. What commands aren't executed by the Snakefile?
2. Execute snakemake with a dry run (`snakemake -n`) -- what error(s) do you see?
3. Look at `make_config.sh`: which parts of the pipeline are missing? Complete and execute.
4. Run snakemake with a dry run again -- the errors should have gone. 
5. Execute the snakemake workflow on the login node, timing how long it takes (`time snakemake -j1`)

### Run your workflow using a slurm profile

1. Install the [snakemake executor plugin for slurm](https://snakemake.github.io/snakemake-plugin-catalog/plugins/executor/slurm.html)
2. Create a slurm profile and save this in your config directory: `~./config/snakemake/slurm_profile/config.yaml`
3. Clean your snakemake workflow (`snakemake clean`)
4. Run your workflow using your profile, timing it: `time snakemake --executor slurm --profile slurm_profile` 

## Things to consider

If you're making changes, consider raising an Issue in your forked github repository, creating a new branch, checking out that new branch and committing and pushing the changes there, then making a pull request.

Once finished, you could update this README.md to explain how to run your pipeline in different environments.


