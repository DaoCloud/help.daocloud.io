default: all

all: build

build: 
	gitbook build
	
upload: build
	qrsync qrsync.json

clean:
	rm -rf _book/

