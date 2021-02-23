RSYNC_FLAGS=-av
GEMINI_DEST=~/public_gemini
HTML_DEST=~/public_html

.PHONY: clean
clean:
	rm -rf public/*

.PHONY: gemini
gemini:
	rsync $(RSYNC_FLAGS) public/*.gmi public/gemini/ $(GEMINI_DEST)/
	rsync $(RSYNC_FLAGS) public/posts/gemini/index.xml $(GEMINI_DEST)/feed.xml

.PHONY: html
html:
	rsync $(RSYNC_FLAGS) public/ --exclude '*.gmi' --exclude gemini $(HTML_DEST)

.PHONY: gen
gen:
	hugo

.PHONY: all
all: clean gen gemini html
