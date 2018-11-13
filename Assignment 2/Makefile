DEPSFILE  = Makefile.deps
NOINCLUDE = ci clean spotless

# Commands
CPP       = g++ -std=gnu++17 -g -O0
CPPWARN   = ${CPP} -Wall -Wextra -Wold-style-cast
CPPYY     = ${CPP} -Wno-sign-compare -Wno-register
GRIND     = valgrind --leak-check=full --show-reachable=yes
FLEX      = flex --outfile=${CLGEN}
BISON     = bison --defines=${HYGEN} --output=${CYGEN}

# Files
MODULES   = string_set auxlib lyutils
HDRSRC    = ${MODULES:=.h}
CPPSRC    = ${MODULES:=.cpp} main.cpp
LSOURCES  = scanner.l
YSOURCES  = parser.y
CLGEN     = yylex.cpp
HYGEN     = yyparse.h
CYGEN     = yyparse.cpp
ALLCGEN   = ${CLGEN} ${CYGEN}
ALLGEN    = ${ALLCGEN} ${HYGEN}
LREPORT   = yyflex.out
YREPORT   = yyparse.out
EXECBIN   = oc
OBJECTS   = ${ALLCSRC:.cpp=.o}
ALLCSRC   = CPPSRC ALLCGEN
ALLSRC    = README Makefile HDRSRC ALLCSRC HYGEN LSOURCES YSOURCES

all : ${EXECBIN}

${EXECBIN} : ${OBJECTS}
	${CPPWARN} -o ${EXECBIN} ${OBJECTS}

yylex.o : yylex.cpp
	${CPPYY} -c $<

yyparse.o : yyparse.cpp
	${CPPYY} -c $<

%.o : %.cpp
	- cpplint.py.perl $<
	${CPPWARN} -c $<

${CLGEN} : ${LSOURCES}
	${FLEX} $<

${CYGEN} ${HYGEN} : ${YSOURCES}
	${BISON} $<

ci : ${ALLSRC} ${TESTINS}
	checksource ${ALLSRC}

grind :
	${GRIND} ${PROGRAM}

clean :
	rm -f *.o ${ALLGENS}

spotless : clean
	rm -f ${EXECBIN}
