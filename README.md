# Grady Ward's Senior Thesis
### Undergraduate Senior Thesis on the Graph Isomorphism Problem

*Started in August 2015, Defense in May 2016*

*Advised by Jim Storrer at Brandeis University*

### TL;DR?

Determining whether or not two graphs are the same is an interesting problem in that
it is neither proven to be in P nor in NP-Complete. Many polynomial time discrimination
algorithms exist which differentiate between graphs (called invariants), though each does so with a different
degree of sophistication and power.  The *Paths Invariant* describes the number of closed paths
that pass through each of the vertices of a graph, and turns out to be a high-power, low cost invariant.

Some notable results thus far are that all graphs
of size <= 9 can be fully determined by the paths invariant, and that the paths invariant
is more discriminating than some high powered invariants.  More interesting though, is the
study of the places where it fails to differentiate two non-isomorphic graphs in V=10: trying to
understand these *co-paths* graphs is my current focus.

### On Copyright and Fair Use

Please note that I make no claim to any of the papers, or packages 
that are posted as a part of this project, I am primarily posting them
to credit their influence on my thinking and remind me to cite them when
the time comes, and to make sure that all of the work that I do on this
project is transparent and replicable.  I do my best to include liscences
when they are used, but I am sure that there are bound to be mistakes and
overlooked problems. If you or anyone else would prefer that any of the code 
or academic works that are posted here not be availible here, please let me
know and I can take them down immediately. 

For the code that I have written for this project,
feel free to use it subject to the share alike creative commons liscence. 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This original components of this work are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

### Why Put This Online?

There are three purposes to this thesis as an open source, version controlled work.

1. Research in academia is far too often done in the dark, and only once the conclusion has
been drawn and sufficently polished does the general public get to learn about it. This 
falsely represents scientific inquiry as a lightning bolt, a blinding and stark progression from correct idea to correct idea. In 
reality we all explore ideas that fail, we all have intutions that turn out to be incorrect, and the reality of
lightning [infinitsimally branching electrical charges](https://www.youtube.com/watch?v=dukkO7c2eUE)
is far more indicative of what research feels and looks like.  

2. If someone else ever has the same intuitions that I do on this subject, maybe they can just
read about it instead of reconstructing all of my dead ends.

3. I work on a personal laptop, a school desktop, and ocassionally a public workstation.
Transferring data (of N different forms) between these computers is tiresome and error prone without
a VCS. 

4. Everyone does better work when they know that their work could be observed.

### Contact and Thoughts

If you have questions, comments, concerns or suggestions, please give me an email at [grady.b.ward@gmail.com](mailto:grady.b.ward@gmail.com)
