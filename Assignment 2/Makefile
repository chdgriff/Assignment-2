DEPSFILE  = Makefile.deps
NOINCLUDE = ci clean spotless

CPP       = g++ -std=gnu++17 -g -O0
CPPWARN   = ${CPP} -Wall -Wextra -Wold-style-cast
GRIND     = valgrind --leak-check=full --show-reachable=yes

MODULES   = string_set auxlib
HDRSRC    = ${MODULES:=.h}
CPPSRC    = ${MODULES:=.cpp} main.cpp
EXECBIN   = oc
ALLCSRC   = ${CPPSRC}
OBJECTS   = ${ALLCSRC:.cpp=.o}
ALLSRC    = README ALLCSRC Makefile

all : ${EXECBIN}

${EXECBIN} : ${OBJECTS}
	${CPPWARN} -o ${EXECBIN} ${OBJECTS}

%.o : %.cpp
	- cpplint.py.perl $<
	${CPPWARN} -c $<

ci : ${ALLSRC} ${TESTINS}
	checksource ${ALLSRC}

grind :
  ${GRIND} ${PROGRAM}

clean :
	rm -f *.o

spotless : clean
	rm -f ${EXECBIN}
