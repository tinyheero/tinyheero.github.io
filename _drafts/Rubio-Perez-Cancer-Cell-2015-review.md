---
layout: post
title:  "Review - \"In Silico Prescription of Anticancer Drugs to Cohorts of 28 Tumor Types Reveals Targeting Opportunities\""
tags: [pan cancer]
---

# Problems

* **High inter-tumor heterogeneity** is a major obstacle to developing and applying therapeutic targeted agents to treat most cancer patients

# Paper Objective

* Comphrehensive assessment of the scope of targeted therapeutic agents in a large pan cancer cohort
* Develop an in silico prescription strategy based on identification of the driver alterations in each tumour and their druggability options

# Materials and Methods

* SNV, INDELS, CNAs, Fusions and RNA-seq expression data on 4068 tumours across 16 TCGA studies. 
* Addition SNVs from 2724 tumours included in 32 exome sequencing studies covering 28 cancer types
* In total, there are 6792 tumours across 48 cohorts (16 TCGA and 32 exome studies)
  

* 104 human FL specimens
* 347 DLBCL specimens

# Results

## Step 1: Identifying Genes Driving Tumorigenesis in 28 Cancer Types

The first step in the in-silico prescription pipeline consisted of identifying all the "driver genes" across the 28 cancer types. Various analyses were performed to do this:

### We Detect 459 Mutational Driver Genes in the 6792 Tumors of the Entire Cohort

* Three methods were applied to detect positively selected mutated genes:
    + Oncodrive-fm
    + MutSigCV
    + OncodriveCLUST

    > The assumption is that mutations in certain genes provide a selective advantage to tumor cells that subsequently grow and proliferate faster; tracing the signals left by the selection across a cohort of tumors identifies the genes driving tumorigenesis

* A total of 459 mutational cancer driver genes acting in one or more tumour types

### A Quarter of Mutational Drivers Are Involved in Cell-Regulatory Mechanisms

* About 25% of the drivers participate in general cell-regulatory processes, which are emerging cancer pathways. Three types of these processes are:
    + Chromatin Regulatory Factors (CRFs)
    + Splcing and mRNA processing regulators (SMRs)
    + Ubiquitin mediated proterolysis system (UPSs)

### The Mode of Action of the 459 Mutational Driver Genes

Drivers mutations (and by extensions that genes that bear them) can be classified into 3 groups:

1. Loss of Function (LoF), tumour suppressor genes whose disrupted function favours tumourigenesis
1. Gain of Funciton (GoF), 
1. Switch of Function (SoF): New function to the encoded protein that promotes malignant transformation

> Identifying mode of action of drivers is crucial to exploring opportunities to therapeutically target drivers, because, in principle, only proteins with activating (Act) muta- tions (GoF plus SoF) can be directly targeted with molecules able to inhibit their function.  LoF genes should be targted through other strategies such as ihibition of a functionally connected gene

* Using OncodriveROLE, they found:
    + 169 Gof cancer genes (36.8%)
    + 207 LoF cancer genes (45%)
    + 83 Uncertainity (18.1%)

### A Limited Number of Drivers Clonally Dominate the Tumors

* Mutations critical to cancer cells should be clonally dominant
* 73 driver genes were biased towards larger clonal frequencies across one or more of the 16 tumoru sample cohorts

### We Identify 38 Drivers Acting via CNAs or Fusions in the Core Cohort

* Considered actionable drivers acting via amplifications, deletions, or gene fusions 
* 29 targeted genes were identified

### The Cancer Drivers Database Identifies Tumorigenic Alterations in 90% of Tumors

* Ninety percent of the 4,068 tumor samples in the core cohort bear at least one driver alteration defined in the Cancer Drivers Database.

## Step 2: Collecting Drugs Targeting Driver Genes

The second step consisted of exhaustively searching for therapeutic options, either approved by the Food and Drug Administration (FDA) or in clinical or pre-clinical studies, to target mutational, CNA, and fusion driver genes detected in step one. 3 different approaches to target them were considered:

1. Inhibition of activated drives with therapeutic molecules (direct targeting)
1. Inhibition of non-altered proteins functionally connected to alter driver (indirect targeting)
1. Gene therapies to compensate for the loss of activity 

### Drugs Targeting Cancer Drivers

Of all the driver genes identified from step 1, only a portion of them had viable drug targets. Specifically, panel A shows:

* 57 FDA-approved agents targeting 51 drivers
* 47 agents in clinical trials targeting 66 drivers (26 on top of the previous 51)
* 20,470 ligands potently binding 77 drivers
* 19 non-reported with respect to the previous lists

In total 96 targeted drivers of which:

* 74 direct targetting
* 13 indirect targetting
* 7 drivers can be targeted directly or indirectly

Also 2 gene therapies aimed at restoring the activity of two drivers

### Cancer Drivers Actionability Database

In addition to the FDA, clinical, and pre-clincal study information, they integrated the information found in the Cancer Drivers Actionability database. This database defines rules for the possible expansions of the use of approved drugs in cancer treatment. 

They identified 6 cases where repurposing of FDA-approved drugs could prove useful and stratified them into three tiers:

1. Tier 1: 
    + Tumour type repurposing (tumour types different from the one considered in the clinical guidelines)
    + Disease repurposing (i.e agents approved for other diseases that are however able to target cancer driver proteins)
2. Tier 2: 
    + alteration repurposing (agents targeting an alteration of a driver that could be employed in the event of another type of alteration of the same gene)
    + indirect targeting repurposing (agents taht target a specific oncoprotein, but have proven useful counteracting the alteration in another connected driver)
    + strong off-target repurposing (agents that bind more potently than drug primary targets)
3. Tier 3:
    + Mild off-target repurposing (agents which bind to off targets with an affinity less potent than the one for their primary).

## Step 3: Connecting Targeted Therapeutic Agents to Patients

This step consists of determining which targeted therapies could benefit a patient; This is classified as the therapeutic landscape. To do this:

1. Selected driver alterations in the tumour on the basis of Cancer Drivers Database
1. Therapies are matched to those alterations taking into account the interactions and rules in the Cancer Drivers Actionability Database

### Approved Targeted Therapies Could Benefit 5.9% of the Patients in the Core Cohort

* Only 5.9% of the patients in the core (study) cohort could be treated with targeted therapies under current clinical guidelines.
    + Moreover, most of the approved targeted approaches are concentrated in 6 tumour types
* When considered only SNVs, only 2.9% of patients can benefit from FDA-approved drugs 

### Drug Repurposing Increases up to 40.2% the Fraction of Patients that Could Benefit from FDA-Approved Drugs

### 1,346, or 33.1% Further Patients in the Cohort Could Benefit from Drugs Currently Under Clinical Trials

### 39% of Patients in the Core Cohort Could Receive Combination Therapies against Multiple Drivers



# Conclusion

* This work uses the largest available tumour cohort (6,792 samples) for 2 major purposes:

1. Determine the scope of applicibility of anticancer targeted drugs
1. Propose ranked lists of genes to develop novel targeted drugs

* An in silico prescription strategy of targeted therapeutic agents was developed which involved the development of
    + Cancer Drivers Database
    + Cancer Drivers Actionability Database
* Connecting these targeted agents to patients in this cohort created a therapeutic landscapes 

