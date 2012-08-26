.PHONY: build clean purge help fullcss compressed cssdir css

ALL_SCSS=$(shell find scss -name *.scss)
ALL_CSS=$(ALL_SCSS:scss/%.scss=css/%.css)

SCSS_OPTIONS=''

default: help

help:
	@echo ''
	@echo 'ADN-Facades Makefile: Targets'
	@echo ''
	@echo '    make build - compile stuff'
	@echo '    make fullcss - compile SCSS to readable CSS'
	@echo '    make compressed - compile SCSS to compressed CSS (for reduced filespace)'
	@echo '    make clean - clean your working dir'
	@echo '    make help  - this message'
	@echo ''

build: compressed
	@echo 'Built.'

css/%.css: scss/%.scss
	@sass $(SCSS_OPTIONS)$< $@
	@echo "converting $< to $@..."

css: cssdir $(ALL_CSS)
	@echo 'Converted all SCSS files.'

cssdir:
	@[[ -d css ]] || mkdir css

fullcss:
	export SCSS_OPTIONS=''
	make css

compressed:
	export SCSS_OPTIONS=' --compressed '
	make css

clean:
	rm -fr css/
	rm -f .sass-cache/
