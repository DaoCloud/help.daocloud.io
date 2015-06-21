default: all

all: build

build: 
	gitbook build
	find _book/ -name "*.html" | xargs sed -i 's/x-icon\">/x-icon\"><link href=\"http:\/\/cdn.bootcss.com\/bootstrap\/3.3.5\/css\/bootstrap.min.css\" rel=\"stylesheet\">/g'
	find _book/ -name "*.html" | xargs sed -i 's/<\/body>/<script src=\"\/js\/navbar.js\"><\/script><\/body>/g'
	cp -r readme.io/* _book
	cp -r img _book
	cp -r js _book
	
upload: build
	qrsync qrsync.json

clean:
	rm -rf _book/

