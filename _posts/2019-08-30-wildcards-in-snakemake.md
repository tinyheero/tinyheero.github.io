---
layout: post
title:  "Accessing Wildcard Values in a Snakemake Rule"
date: 2019-08-30
tags: [snakemake]
---

If you are familiar with [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html), 
then you will likely have used [wildcards](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#wildcards)
before. For instance, consider the following rule in our `Snakefile`:

```python
rule get_patient_output:
    input: "{patient_id}_input.tsv"
    output: "{patient_id}_output.tsv"
    shell:
        """
        touch {output}
        """
```

Here we have a rule `get_patient_output` that contains a wildcard represented by 
`{patient_id}`. When we run:

```bash
touch patientA_input.tsv;
snakemake patientA_output.tsv;
```
```
Building DAG of jobs...
Using shell: /usr/local/bin/bash
Provided cores: 1
Rules claiming more threads will be scaled down.
Job counts:
        count   jobs
        1       get_patient_output
        1

[Thu Aug 29 22:56:57 2019]
rule get_patient_output:
    input: patientA_input.tsv
    output: patientA_output.tsv
    jobid: 0
    wildcards: patient_id=patientA

[Thu Aug 29 22:56:57 2019]
Finished job 0.
1 of 1 steps (100%) done
```

Snakemake is able to recognize that we want to make `patientA_output.tsv` and
is able to do this as long as the prerequisite file is available, which in this 
case is the `patientA_input.tsv` file. Since we created the prerequisite file
by running `touch`, this command runs to completion creating the output file
we desire. 

Since we have a wildcard in the rule, we can reuse the rule by simply changing
the patient identifier. For instance, if we ran the following:

```bash
touch patientB_input.tsv;
snakemake patientB_output.tsv;

touch patientC_input.tsv;
snakemake patientC_output.tsv;
```

Snakemake would use the same rule in each instance because of the wildcard. This 
will generally be your first introduction to using wildcards in Snakemake and it 
is very powerful in enabling rule reusage in workflows. **In other words, rather
than explicitly writing out a rule for each file you want to generate. You can
use wildcards in rules to allow the same rule to be used to generate multiple
outputs.**

# Accessing the Wildcard Values Using Lambda Functions

But what happens if you need to do something a bit more sophisticated such as 
needing the wildcard value to be an index to other files. For instance, say you 
had the following dictionary storing the gene mutations that each patient has:

```python
patient_gene_mutations = {
  "patientA": ["RCOR1", "TP53", "KRAS"],
  "patientB": ["NCOR1", "CDKN2A", "B2M"]
}
```

You then had a rule that required as input each patient's gene mutation files.
In other words, I want to make a patient output file but I want the prerequistes 
to be the files containing information on the gene mutations specific to this 
patient. What you would need to do is access `patient_gene_mutations` dictionary 
in your rule to extract out the gene identifiers associated with the patient. 
However, the patient identifier is a wildcard in the rule. 

This is where anonymous `lambda` functions come in handy as they give you 
access to the wildcards of the rule. With it, you can construct more complex
rule prequisites. For instance, consider the following Snakefile:

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

In the `get_patient_output` rule, we use a `lambda` function to construct a list
of input files that the rule needs. Importantly, we can access the patient 
identifier wildcard value using `wildcards.patient_id`. This allows us to gather
a list of gene mutation input files, which are specific to the patient 
identifier.

When you run:

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

# Conclusions

With this trick, you should be able to construct more complex rules to help with 
your workflows! Just bear in mind that the `lambda` function [unfortunately does 
not work in the output directive](https://bitbucket.org/snakemake/snakemake/issues/735/use-lambda-functions-in-outputs).

# References

* [Mix globbing and wildcards when specifying rule input](https://bioinformatics.stackexchange.com/questions/7184/mix-globbing-and-wildcards-when-specifying-rule-input)
