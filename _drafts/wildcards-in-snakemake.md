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
What you e

```python
rule get_patient_output:
    input: 
    output: "{patient_id}_output.tsv"
    shell:
        """
        {wildcards.patient_id}
        """
```




