package test;
import static org.junit.Assert.*;

import org.junit.Test;

import Verification.Graph6;


public class TestGraph6 {

	@Test
	public void testSimpleGraph(){
		int[][] expected = {
			{0,	0,	0,	0,	1,	1,	1},
			{0,	0,	0,	0,	1,	0,	0},
			{0,	0,	0,	0,	0,	1,	0},
			{0,	0,	0,	0,	0,	0,	0},
			{1,	1,	0,	0,	0,	0,	1},
			{1,	0,	1,	0,	0,	0,	1},
			{1,	0,	0,	0,	1,	1,	0},
		};
		int[][] g = Graph6.retrieveGraph("F?qcW");
		for (int i = 0; i < 7; i++){
			for (int j = 0; j < 7; j++){
				assertEquals(expected[i][j], g[i][j]);
			}
		}
	}
	
}
