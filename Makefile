exec = hermes.out
sources = $(wildcard src/*.c)
objects = $(sources:.c=.o)
flags = -g -lm


$(exec): $(objects)
	gcc $(objects) $(flags) -o $(exec)

libhermes.a: $(objects)
	ar rcs $@ $^

%.o: %.c include/%.h
	gcc -c $(flags) $< -o $@

install:
	make
	mkdir -p /usr/local/include/hermes
	cp -r ./src/include/* /usr/local/include/hermes/.
	cp ./libhermes.a /usr/local/lib/.

clean:
	-rm *.out
	-rm *.o
	-rm *.a
	-rm src/*.o

lint:
	clang-tidy src/*.c src/include/*.h