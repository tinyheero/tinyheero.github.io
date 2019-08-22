---
layout: post
title:  "Accessing the Wildcards in a Snakemake Rule"
tags: [tiddlywiki]
---

If you are familiar with Makefiles, then you'll be familiar with wildcards. For
instance:

```make
%_output.tsv : %_input.tsv
    touch $@
```

Here we have a recipe that contains a wildcard represented by the `%` symbol.

accepts a single pre-requistie and makes the file

When we run:

```bash
touch patientA_input.tsv;
make patientA_output.tsv;
```

The equivalent recipe (called a rule) in Snakemake would be:


```python
rule get_patient_output:
    output: "{patient_id}_output.tsv"
    shell:
        """
        {wildcards.patient_id}
        """
```

The beauty

You can use the `wildcards`

What happens if you need to do something a bit more sophisticated such as
needing the wildcard to access multiple files. For instance, say you had the
following dictionary containing the gene mutations that each patient had.

```python
patient_gene_mutations = {
  "patientA": ["RCOR1", "TP53", "KRAS"],
  "patientB": ["NCOR1", "CDKN2A", "B2M"]
}
```

You then had a recipe that required as input each patient gene mutation files.
What you would need to do is access patient_gene_mutations dictionary to extract
out the gene identifiers associated with the patient. However, the patient
identifier is a wildcard in the recipe.

This is where anonymous lambda functions comes very handy. I didn't find the
lambda functionality in Snakemake to be documented quite well. But the gist of
it is you can use it to access the wildcards. For instance, consider the 
following Snakefile:

```python
patient_gene_mutations = {
  "patientA": ["RCOR1", "TP53", "KRAS"],
  "patientB": ["NCOR1", "CDKN2A", "B2M"]
}

rule all:
    input:
        "patient_data/patientA_output.tsv",
        "patient_data/patientB_output.tsv"

rule get_mutation_file:
    output:
        "mutation_data/{gene_id}_output.tsv"
    shell:
        """
        touch {output}
        """

rule get_patient_output:
    input:
        lambda wildcards: \
            ["mutation_data/{0}_output.tsv".format(gene_id) \
                for gene_id in patient_gene_mutations[wildcards.patient_id]
            ]
    output:
        "patient_data/{patient_id}_output.tsv"
    shell:
        """
        touch {output}
        """
```

In the `get_patient_output` rule, we use a lambda function to construct a list
of input files that the rule needs. These input files are the mutation data
files required for the specific patient. When you run:

```bash
snakemake all
```

This ends up producing the following structure:

```
├── Snakefile
├── mutation_data
│   ├── B2M_output.tsv
│   ├── CDKN2A_output.tsv
│   ├── KRAS_output.tsv
│   ├── NCOR1_output.tsv
│   ├── RCOR1_output.tsv
│   └── TP53_output.tsv
└── patient_data
    ├── patientA_output.tsv
    └── patientB_output.tsv
```
