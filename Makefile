CMD_FILES=$(shell ls)

config: build
	for i in $(shell find config); do \
		path=$$(echo "$$i" | cut -c7-) ; \
		echo $$i ; \
		if [[ -d $$i ]]; then \
			mkdir -p $$path \
		elif [[ -f $$i ]]; then \
			ln -f $$i $$path \
		fi \
	done

build:
	go mod tidy
	for i in $(shell ls cmd) ; do \
		cd cmd/$$i ; \
		echo "Building $$i" ; \
		go build -o ../../bin/$$i main.go && echo 'Build successful' ; \
		cd ../.. ; \
	done


install: build
	cp -f bin/* /usr/bin/
	cp -f scripts/* /usr/bin

uninstall:
