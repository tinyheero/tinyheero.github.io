---
layout: post
title:  "Neural Networks"
tags: [ishl10]
---

# Introduction

* Artifical neutral networks (ANN) are built wtihout specific logic; Trained to look for, and  adapt to, patterns within data.
    + This is unlike decision trees which is pre-determined.
    + A neural network, simply responds to data confirming or denying the frequency of the neuron “heat” being connected to the neuron “mug.”
* Neural networks are algorithms that try to mimic the brain
  + Computational expensive
* 

# Model Representation

* Simulating neurons
    + Output wire is called an axon.
* A neuron is a computational unit that:
    1. Takes input
    1. Does computation to input
    1. Outputs the results.
* Neuron model: Logistic unit
+ X0 - bias unit
    + This is included and always 1 such that if all the other inputs to the neuron are 0, then the neuron will still activate.
+ Sigmoid (logistic) activation function.
+ Neutral network is a group of neurons strung together
   + Layer 1 - Input layer
   + Layer 2 - "Hidden layer": Basically anything that isn't an input layer or output layer is called a hidden layer.
   + layer 3 - Output layer
+ Neurons are connected to each other via synapses.
   + Each synapse has a value representing the likelihood of the connection between two neurons to occur.
   + The strength of the synapse connecting each neuron determines the likelihood that one is connected to the other.

# Process

* neuron calculates it's "state" by "adding all the incoming inputs multiplied by its corresponding connection weight"
* After computing its state, it goes to the activation function:
    + the activation function is usually a sigmoid function, either a Logistic or an Hyperbolic Tangent.
    + normalize the outut to be between 0-1 (usually)

# Types of Neural Networks

* Feed-forward Network: This is the simplest architecture, it consists of organizing the neurons in layers, and connecting all the neurons in one layer to all the neurons in the next one, so the output of every layer (which is the output of every neuron in that layer) becomes the input for the next layer.

# References

* [Beginner’s Guide To Neural Networks](https://medium.com/swlh/beginners-guide-to-neural-networks-c98f496eec64#.cfdr6lqlx)
* [Nature Biotechnology - What are artificial neural networks?](http://www.nature.com/nbt/journal/v26/n2/full/nbt1386.html)
* [Neural Networks 101](https://github.com/cazala/synaptic/wiki/Neural-Networks-101)
