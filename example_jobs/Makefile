#--- config

CC = mpicc
CFLAGS = -O0

PROG = mpi_hello_world cpu_user_parallel cpu_waster_parallel


#--- building

all: $(PROG)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

mpi_hello_world: mpi_hello_world.o
	$(CC) $(LDFLAGS) $< -o $@

cpu_user_parallel: cpu_user_parallel.o
	$(CC) $(LDFLAGS) $< -o $@

cpu_waster_parallel: cpu_waster_parallel.o
	$(CC) $(LDFLAGS) $< -o $@


#--- cleaning

clean:
	rm -f $(PROG) *.o *.so *.out *.err
