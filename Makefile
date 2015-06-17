default: all

all: build

build: 
	gitbook build
	cp -r readme.io/* _book
	cp -r img _book
	
upload: build
	qrsync qrsync.json

clean:
	rm -rf _book/

