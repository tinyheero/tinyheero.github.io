---
layout: post
title:  "Mutation Signatures"
tags: [LDA]
---

There are 12 different possible mutation base substitutions:

1. A > C
1. A > G
1. A > T
1. C > A
1. C > T
1. C > G
1. T > A
1. T > C
1. T > G
1. G > A
1. G > T
1. G > C

But we can actually collapse this down to 6 base substitutions by leveraging the idea of "strand symmetry". Because each base exists as a base pair, the mutation is really based on the respective strand you are looking at. For instance, consider the base pairing:

---A---
---T---

If a mutation occurred at this position (A > G), then the base pairing becomes:

---C---
---G---

But we looked at it from the perspective of the forward strand. But we could have also looked at it from the negative strand perspective which would have been T > G. This means that A > G mutations are essentially equivalent to T > G mutations. This means that for each base substitution, there is a corresponding base substitution which is the same based on strand symmetry. With that logic, we can collapse 12 different possible mutation base substitution in 6:

1. A > C; T > G
1. A > G; T > C 
1. A > T; T > A
1. C > A; G > T
1. C > T; G > A
1. C > G; G > C

# References

