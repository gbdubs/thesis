/* * Include Guards * * */
#ifndef SIMRECORDER_H_INCLUDED
#define SIMRECORDER_H_INCLUDED
/* * Include Guards * * */

/* * * * * * * * * * * * * * * * * * * * */
/*        SIMILARITY RECORDER            */
/* * * * * * * * * * * * * * * * * * * * */
void beginRecording(int v, int e);

void recordSimilar(int** graph1, int** graph2);

void finishRecording();

#endif