DEPSFILE  = Makefile.deps
NOINCLUDE = ci clean spotless

# Commands
CPP        = g++ -std=gnu++17 -g -O0
CPPWARN    = ${CPP} -Wall -Wextra -Wold-style-cast
CPPYY      = ${CPP} -Wno-sign-compare -Wno-register
FLEX       = flex --outfile=${CLGEN}
BISON      = bison --defines=${HYGEN} --output=${CYGEN}

# Files
MODULES    = string_set auxlib lyutils astree
HDRSRC     = ${MODULES:=.h}
CPPSRC     = ${MODULES:=.cpp} main.cpp
LSOURCES   = scanner.l
YSOURCES   = parser.y
ALLSOURCES = ${LSOURCES} ${YSOURCES}
CLGEN      = yylex.cpp
HYGEN      = yyparse.h
CYGEN      = yyparse.cpp
ALLCGEN    = ${CLGEN} ${CYGEN}
ALLGEN     = ${ALLCGEN} ${HYGEN}
LREPORT    = yyflex.output
YREPORT    = yyparse.output
EXECBIN    = oc
OBJECTS    = ${ALLCSRC:.cpp=.o}
ALLCSRC    = ${ALLCGEN} ${CPPSRC}
ALLSRC     = README Makefile ${HDRSRC} ${ALLCSRC} ${HYGEN} ${ALLSOURCES}

all : ${EXECBIN}

${EXECBIN} : ${HYGEN} ${OBJECTS}
	${CPPWARN} -o ${EXECBIN} ${OBJECTS}

yylex.o : yylex.cpp
	${CPPYY} -c $<

yyparse.o : yyparse.cpp
	${CPPYY} -c $<

${CPPSRC:.cpp=.o} : ${CPPSRC}
	${CPPWARN} -c ${CPPSRC}

${CLGEN} : ${LSOURCES}
	${FLEX} $<

${CYGEN} ${HYGEN} : ${YSOURCES}
	${BISON} $<

clean :
	rm -f *.o ${ALLGEN} ${LREPORT} ${YREPORT}

spotless : clean
	rm -f ${EXECBIN}
