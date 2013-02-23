CC=coffee
OUT=lib
IN=src

all: lib
	${CC} -o ${OUT} -c ${IN}

lib:
	mkdir lib

