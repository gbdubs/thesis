# Grady Ward's Senior Thesis
### Undergraduate Senior Thesis on the Graph Isomorphism Problem

*Started in August 2015, Completed by April 20th, Defeded on May 11th 2016*

*Advised by Jim Storer at Brandeis University*

### TL;DR

An interesting procedure is counting the number of closed paths that pass through every vertex in the graph of a given length.
It turns out that we can do this very quickly, relative to how much information it gives us.
Counting the number of closed paths gives us a kind of local resonance, a description of the localized area around each vertex within the graph, as a integer vector. 
It turns out that this idea can be transformed into a numerical property, called an invariant, which is highly information dense--able to describe differences between graphs with high probability, but not sufficient to verify that two graphs are the same.

There are a lot of graphs, even over a small number of vertices, but the number is much larger if you consider different labelings of the same graph to be distinct.
This difference matters in many contexts, but is most evident through examining random graph generators, which treat labelings as if they are distinct structures. 
This is not a problem in and of itself (it makes sense in practical contexts), but it warps theoretic arguments about the runtime of algorithms over `random' graphs.
It turns out that making up our own random graph generators can actually improve upon this state of affairs in a quantifiable way.


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

An interesting aspect of this thesis has been that I have placed every incremental iteration of my work online, through git version control and github.
Every element, from my reading notes, to my mid-semester reports, to my code, results, and datasets: everything has been kept in a central repository, and every change has been committed and logged.
This also means that all of the code that I have written is open source, and licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.

There are four reasons to make this thesis as an open source, version controlled work.

1. Research in academia is far too often done in the dark, and only once the conclusion has been drawn and sufficiently polished does the general public get to learn about it.  This falsely represents scientific inquiry as a lightning bolt, a blinding and stark progression from correct idea to correct idea.  In reality we all explore ideas that fail, we all have intuitions that turn out to be incorrect. The reality of research is much more one of lightning's infinitesimally branching electrical charges (with eventual connection).

2. If someone else ever has the same intuitions that I do on this subject, maybe they can just read about it instead of reconstructing all of my dead ends.

3. I work on a personal laptop, a school desktop, and occasionally a public workstation. Transferring data (of all sorts) between these computers is tiresome and error prone without a VCS.

4. Everyone does better work when they know that their work could be observed.

### Contact and Thoughts

If you have questions, comments, concerns or suggestions, please give me an email at [grady.b.ward@gmail.com](mailto:grady.b.ward@gmail.com)
