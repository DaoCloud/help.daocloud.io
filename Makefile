INJECT_HEADER := `cat inject/header.html | tr -d '\n'`

default: all

all: build

build: 
	gitbook build
	find _book/ -name "*.html" -exec sed -i "s#<body>#<body>$(INJECT_HEADER)#g" '{}' \;
	find _book/ -name "*.html" -exec sed -i "s#gitbook/images/favicon.ico#img/favicon.ico#g" '{}' \;
	cp -r readme.io/* _book
	
upload: build
	qrsync qrsync.json

clean:
	rm -rf _book/

