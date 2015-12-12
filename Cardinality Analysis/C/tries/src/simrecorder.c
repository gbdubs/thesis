#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"

/* * * * * * * * * * * * * * * * * * * * */
/*        SIMILARITY RECORDER            */
/* * * * * * * * * * * * * * * * * * * * */

const char loggingPath[] = "/home/u/fall12/gward/Desktop/thesis/Cardinality Analysis/C/tries/similarities/%d-%d.txt";
const char metaLoggingPath[] = "/home/u/fall12/gward/Desktop/thesis/Cardinality Analysis/C/tries/similarities/%d-%d-meta.txt";

int nSimilar;

FILE* metaLogger = NULL;
FILE* logger = NULL;

void metaLogS(char s[]){
	fprintf(metaLogger, "%s\n", s);
}

void metaLogSI(char s[], int i){
	fprintf(metaLogger, "%s%d\n", s,i);
}

void logS(char s[]){
	fprintf(logger, "%s\n", s);
}

void beginRecording(int v, int e){
	int variableSize = (v >= 10) + (e >= 10) + 2;
	if (logger == NULL){
		int patternSize = ((sizeof(loggingPath)/sizeof(char)) + variableSize);
		char logPath[patternSize];
		sprintf(logPath, loggingPath, v, e);

		logger = fopen(logPath, "w");
		if (logger == NULL){
			{
			    printf("Error Opening File [%s]\n", logPath);
			    exit(1);
			}
		}
	}
	
	if (metaLogger == NULL){
		int metaPatternSize = ((sizeof(metaLoggingPath)/sizeof(char)) + variableSize);
		char metaLogPath[metaPatternSize];
		sprintf(metaLogPath, metaLoggingPath, v, e);

		metaLogger = fopen(metaLogPath, "w");
		if (metaLogger == NULL){
			{
			    printf("Error Opening File [%s]\n", metaLogPath);
			    exit(1);
			}
		}

		metaLogS("==========================================");
		metaLogS("==== Began Recording All Similarities ====");
		metaLogS("==========================================\n");
	}
	nSimilar = 0;
}       

void recordSimilar(int** graph1, int** graph2){
	char* encoding1 = encodeGraph(graph1);
	char* encoding2 = encodeGraph(graph2);
	metaLogS("----- SIMILAR PAIR! ------");
	metaLogS(encoding1);
	metaLogS(encoding2);
	metaLogS("--------------------------\n");
	logS(encoding1);
	logS(encoding2);
	nSimilar++;
	nSimilar++;
}

void finishRecording(){
	metaLogSI("Number of Similar Graphs: ", nSimilar);
	metaLogS("");
	metaLogS("==========================================");
	metaLogS("== Finished Recording All Similarities ===");
	metaLogS("==========================================");
	fclose(metaLogger);
	fclose(logger);
}

/*
int main(){
	beginRecording(10, 84);
	for(int i = 1; i < 10; i++){
		recordSimilar(createMatrix(i, i), createMatrix(i, i));
	}
	finishRecording();
}
*/