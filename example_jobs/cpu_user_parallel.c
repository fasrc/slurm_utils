#include <stdlib.h>
#include <time.h>
#include <mpi.h>

int LIFETIME = 60;  //seconds

int main(int argc, char **argv) {
	MPI_Init(&argc, &argv);
	
	int myrank;
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

	if (1) {
		int t_start = (int)time(NULL);
		while (1) {
			int i;
			for (i=1; i<999999; i++) 1.1*1.1;  //busy work
			if ((int)time(NULL) - t_start >= LIFETIME) break;
		}
	}

	MPI_Finalize();
	exit(EXIT_SUCCESS);
}
