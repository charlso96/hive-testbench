CXX = g++
$HADOOP_HOME = /data/hadoop
LIB = -I$(HADOOP_HOME)/include -L$(HADOOP_HOME)/lib/native -L/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.362.b08-1.amzn2.0.1.x86_64/jre/lib/amd64/server -lhdfs

all: listfiles

listfiles: listfiles.cpp
	$(CXX) $< $(LIB)  -o $@

clean:
	rm listfiles



