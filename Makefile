#CFLAGS=-g -std=c++11 
CFLAGS=-O3 -std=c++11 
#CFLAGS=-O3 -std=c++11 -mcmodel=medium
PFLAGS=-ltbb
VERS=

pagerank_test : pagerank_test.cpp table$(VERS).cpp pagerank.cpp tbb_init.cpp table.h 
	g++ $(CFLAGS) -o pagerank_test$(VERS)_exe  pagerank_test.cpp table$(VERS).cpp tbb_init.cpp $(PFLAGS)
pagerank : pagerank.cpp table.cpp table.h
	g++ $(CFLAGS) -Wall -o pagerank$(VERS)_exe pagerank.cpp table.cpp 

all-tests: all-tests.txt pagerank_test
	./pagerank_test$(VERS)_exe  all-tests.txt

small-test: small pagerank_test
	./pagerank_test small

medium-test: medium pagerank_test
	./pagerank_test$(VERS)_exe  medium

large-test: large pagerank_test
	./pagerank_test$(VERS)_exe  large

enormous-test: enormous pagerank_test
	./pagerank_test$(VERS)_exe  enormous

ginormous-test: ginormous pagerank_test
	./pagerank_test$(VERS)_exe  ginormous

clean:
	rm -f *_exe
