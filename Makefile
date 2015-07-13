.PHONY: all

all: build

imagemin: build

%:
	sh $@.sh
