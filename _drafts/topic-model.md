---
layout: post
title:  "Latent Dirichlet Allocation"
tags: [LDA]
---

* Latent Dirichlet Allocation (LDA) is a type of topic modeling
* Find hidden structure in a group of documents
    + It it generate topics and their word frequencies without any input topics?
* A topic is modelled as a distribution over words (vocabulary)

# Definitions

* Document: Mixture of topics.
* Topic: Links words in a vocabulary and their occurence in documents.
* Words (aka. terms): The basic unit of data in a document.
* Vocabulary: Set of all words.
* Tokenization: Splitting up a document into words.
* Document-term matrix (DTM): Matrix that shows the frequency of words in documents.
* Corpus (text corpus): Large and structured set of texts.

# Assumptions

* Bag-of-words assumption: Words in a document are exchangeable and their order therefore is not important.
* Found whether any two topics are similiar based on their words
* Characteristics of topics and documents are drawn from dirichlet distributions.

# Generative Process

* To infer topics from a corpus, one has to have a certain model of how documents are generated. The LDA's generated model can be summarized as:

1. For each topic: decide what words are likely.
1. For each document,
    + decide what proportions of topics should be in the document,
    + for each words, 
        - choose a topic,
        - given this topic, choose a likely word (generated in step 1)

# Input

* Bags of words per document
    + documents are not labeled with any topics.
* Hidden random variables:
    + topic distribution per document
    + distribution over the vocabulary per topic
    + per-document per-word topic assignment
* inormation on the topics are unknown
    + In other words, we don't need to know the topics (i.e. biology, computer science) ahead of time.

# Output

* Distribution of words over a topic
* Distribution of a topic over documents. In other words, how much does each topic contribute to a document.
+ Posterior of the hidden variables given the value of the observed variables

# Graphic Model of LDA

![LDA Model Plate Notation](https://upload.wikimedia.org/wikipedia/commons/d/d3/Latent_Dirichlet_allocation.svg)

* The boxes are “plates” representing replicates. 
    + Outer plate represents documents
    + Inner plate represents the repeated choice of topics and words within a document. 

* M denotes the number of documents.
* N the number of words in a document.
* alpha: is the parameter of the Dirichlet prior on the per-document topic distributions.
* β is the parameter of the Dirichlet prior on the per-topic word distribution.
* <span class="inlinecode">$\theta\_{i}$</span> is the topic distribution for document i.
* <span class="inlinecode">$\varphi\_{k}$</span> is the word distribution for topic k.
* <span class="inlinecode">$z\_{ij}$</span> is the topic for the jth word in document i.
* <span class="inlinecode">$w\_{ij}$</span> is the specific word. This is the only observed data.


# References

* [Wikipedia Page](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation)
* [Latent Dirichlet Allocation in R - Martin Ponweiser's Diploma Thesis](http://epub.wu.ac.at/3558/1/main.pdf)
* [LDA Topic Models](https://www.youtube.com/watch?v=ePUAZ8RG-3w)
* [Topic modeling and LDA.mpeg](https://www.youtube.com/watch?v=Acs_esny-qQ&list=PLgsYMpI8sy8GIESzbn6XLfQWVfyBj3Gqe)
* [Topic Modeling in R](http://www.bigdatanews.com/profiles/blogs/topic-modeling-in-r)
