# -*- mode: snakemake -*-

configfile:"config.yml"

rule all:
	"The default rule"
	input:
		fig_words=expand("results/wordcloud_{condition}.png",condition=config["CONDITIONS"]),
		fig_bigrams=expand("results/bigramcloud_{condition}.png",condition=config["CONDITIONS"])

rule setup:
	"setup"
	shell:"""
	mkdir results
	"""


for condition in config["CONDITIONS"]:
	rule:
		name:
			f"side_effects_{condition}"
		input:
			"data/original/drugLibTrain_raw.tsv"
		output:
			f"data/derived/word_rankings_{condition}.csv"
		shell:
			f"Rscript code/1_find_side_effects.R {condition}"


for condition in config["CONDITIONS"]:
	rule:
		name:
			f"plot_{condition}"
		input:
			f"data/derived/word_rankings_{condition}.csv"
		output:
			f"results/wordcloud_{condition}.png",
			f"results/bigramcloud_{condition}.png"
		shell:
			f"Rscript code/2_plot_wordcloud.R {condition}"

rule clean:
	"Clean up"
	shell:"""
	if [ -d results ]; then
	rm -r results
	else
		echo directory results does not exist
	fi
	"""
