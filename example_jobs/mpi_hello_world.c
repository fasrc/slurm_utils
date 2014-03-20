#include <mpi.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/utsname.h>

#define NODEMSG_SIZE 32
#define BUFF_SIZE 128
#define TAG 0

#define MASTER 0

int main(int argc, char **argv) {
	char nodemsg[NODEMSG_SIZE];
	char buff[BUFF_SIZE];
	int nranks;
	int myrank;
	MPI_Status status;
	
	int i;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &nranks);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
	
	struct utsname uname_result;
	if (uname(&uname_result)) {
		fputs("*** ERROR *** unable to lookup hostname\n", stderr);
		perror("");
		exit(EXIT_FAILURE);
	}

	if (myrank == MASTER) {
		printf("master processor %d, host %s: total of %d processors\n", myrank, uname_result.nodename, nranks);
		for (i=1; i<nranks; i++) {
			sprintf(buff, "hello from processor %d to processor %d;", myrank, i);
			MPI_Send(buff, BUFF_SIZE, MPI_CHAR, i, TAG, MPI_COMM_WORLD);
		}
		for (i=1; i<nranks; i++) {
			MPI_Recv(buff, BUFF_SIZE, MPI_CHAR, i, TAG, MPI_COMM_WORLD, &status);
			printf("master processor %d: %s\n", myrank, buff);
		}
	}
	else {
		MPI_Recv(buff, BUFF_SIZE, MPI_CHAR, MASTER, TAG, MPI_COMM_WORLD, &status);
		sprintf(nodemsg, "ack from processor %d, host %s, of msg: ", myrank, uname_result.nodename);
		strcat(nodemsg, buff);
		
		MPI_Send(nodemsg, BUFF_SIZE, MPI_CHAR, MASTER, TAG, MPI_COMM_WORLD);

		/*
		for (i=1; i<999999; i++) {
			int count = 1;
			while (count<=999999999) {
				count += 1;
			}
		}
		*/
	}

	MPI_Finalize();

	exit(EXIT_SUCCESS);
}
