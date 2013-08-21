target=hostbyname
all:${target}

hostbyname:hostbyname.o
	g++ -o $@ $^ -g -O2
	
.cpp.o:
	g++ -o $@ -c $^ -g -O2

install:all
	rm -rf bin 
	mkdir bin 
	mv ${target} bin/
	mkdir -p ~/.toolbox/bin	
	mv bin/* ~/.toolbox/bin/


PHONY:clean

clean:
	rm -rf *.o
	rm -rf ${target} 
	rm -rf bin


